class Security < ApplicationRecord
  belongs_to :user
  belongs_to :issuer
  belongs_to :security_type
  has_many :bids, dependent: :destroy
  # validates :mode, presence: true
  validates :code, presence: true
  validates :maturity, presence: true, date: true
  validates :price, presence: true, numericality: true
  validates :date_limit, presence: true, date: true
  validates :quantity, presence: true, numericality: { only_integer: true }
  validates :rate, presence: true, numericality: true
  validates :indexer, presence: true
  validates :unit_price, presence: true, numericality: true
  validates :issue_date, presence: true, date: true
  validate :maturity_cannot_be_in_the_past, on: :create
  validate :date_limit_cannot_be_in_the_past, on: :create
  validate :validate_date_limit_before_maturity, on: :create
  validate :maturity_cannot_be_before_issue_date
  validate :issue_date_cannot_be_in_future
  mount_uploader :file, FileUploader

  def value
    quantity * unit_price
  end

  def time_elapsed
    (Time.current.to_date - issue_date).to_i
  end

  def current_value
    n = time_elapsed * (360.to_f/365)
    pv = value
    i_dia = ((hp12c_interest.to_f / 100)+1)**(1.to_f/360)
    fv = pv.to_f * ((i_dia.to_f)**(n.to_f))
    fv
  end

  def time_to_maturity
    (maturity - Time.current.to_date).to_i
  end


  def cdi
    # site_cetip = Nokogiri::HTML(open("https://www.cetip.com.br/").read)
    # cdi = site_cetip.search('.txt-taxa-porcentagem span#ctl00_Banner_lblTaxDI').text.gsub(/,/,".").gsub(/%/,"").to_f
    9.14
  end

  def cdi_12m
    # site_anbima = Nokogiri::HTML(open("http://www.anbima.com.br/pt_br/informar/estatisticas/precos-e-indices/indicadores.htm").read)
    # cdi_12m = site_anbima.search('.card-body.full.comp-especifico.tab-8col.tab-indicadores .both')
    # ((cdi_12m[1].search("div")[5].text.gsub(/,/,".").gsub(/%/,"").to_f)/100)+1
    11.69
  end

  def ipca
    # site_calculador = Nokogiri::HTML(open("http://www.calculador.com.br/tabela/indice/IPCA").read)
    # ipca = site_calculador.search('#tabela-indice')
    # ipca.search(".text-center")[3].text.gsub(/,/,".").to_f
    2.71
  end

  def igpm
    # site_calculador = Nokogiri::HTML(open("http://www.calculador.com.br/tabela/indice/IGP-M").read)
    # igpm = site_calculador.search('#tabela-indice')
    # igpm.search(".text-center")[3].text.gsub(/,/,".").to_f
    -1.67
  end

  def hp12c_interest
    if indexer == "PRE"
      rate.to_f
    elsif indexer == "CDI"
      rate.to_f * (cdi_12m.to_f/100)
    elsif indexer == "IPC-A+"
      rate.to_f + ipca
    elsif indexer == "IGP-M+"
      rate.to_f + igpm
    end
  end

  private

  def maturity_cannot_be_in_the_past
    if maturity.present? && maturity < Date.today
      errors.add(:maturity, "Título não pode estar vencido")
    end
  end

  def date_limit_cannot_be_in_the_past
    if date_limit.present? && date_limit < Date.today
      errors.add(:date_limit, "Escolha uma data futura")
    end
  end

  def validate_date_limit_before_maturity
    if date_limit > maturity
      errors.add(:date_limit, "Título não pode ser aberto para negociação após data de vencimento")
    end
  end

  def maturity_cannot_be_before_issue_date
    if maturity < issue_date
      errors.add(:maturity, "A data de vencimento tem que ser depois da data de emissão")
    end
  end

  def issue_date_cannot_be_in_future
    if issue_date.present? && issue_date > Date.today
      errors.add(:issue_date, "A data de emissão não pode ser uma data fútura")
    end
  end
end
