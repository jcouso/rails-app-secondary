module ApplicationHelper
  def time_to_maturity
    (@security.maturity - Time.current.to_date).to_i
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

  def gross_profitability
    (@bid.rate.to_f)
  end

  def net_profitability
    if time_to_maturity <= 180
      (@bid.rate.to_f * 0.775)
    elsif time_to_maturity <= 360
      (@bid.rate.to_f * 0.8)
    elsif time_to_maturity <= 720
      (@bid.rate.to_f * 0.825)
    else
      (@bid.rate.to_f * 0.85)
    end
  end

  def gross_profitability_cdi
    (gross_profitability.to_f / cdi)
  end

  def net_profitability_cdi
    (net_profitability.to_f / cdi)
  end

  def price_calc
    n = time_to_maturity.to_f * (360.to_f/365)
    pv = @security.value
    i_dia = ((@bid.rate.to_f / 100)+1)**(1.to_f/360)
    @bid.price = (pv.to_f * ((i_dia)**(n.to_f)))
  end

  def rate_calc

  end

  def hp12c
    n = time_to_maturity * (360.to_f/365)
    pv = @security.value
    i_dia = ((hp12c_interest.to_f / 100)+1)**(1.to_f/360)
    fv = pv.to_f * ((i_dia.to_f)**(n.to_f))
    fv
  end

  def hp12c_interest
    if @security.indexer == "PRE"
      @security.rate.to_f
    elsif @security.indexer == "CDI"
      @security.rate.to_f * cdi
    elsif @security.indexer == "IPC-A+"
      @security.rate.to_f + ipca
    elsif @security.indexer == "IGP-M+"
      @security.rate.to_f + igpm
    end
  end
end
