module ApplicationHelper
  def cdi
    site_cetip = Nokogiri::HTML(open("https://www.cetip.com.br/").read)
    ((cdi = site_cetip.search('.txt-taxa-porcentagem span#ctl00_Banner_lblTaxDI').text.gsub(/,/,".").gsub(/%/,"").to_f)/100)+1
  end
  def time_to_maturity
    (@security.maturity - Time.current.to_date).to_i
  end

  def cdi_12m
    site_anbima = Nokogiri::HTML(open("http://www.anbima.com.br/pt_br/informar/estatisticas/precos-e-indices/indicadores.htm").read)
    cdi_12m = site_anbima.search('.card-body.full.comp-especifico.tab-8col.tab-indicadores .both')
    ((cdi_12m[1].search("div")[5].text.gsub(/,/,".").gsub(/%/,"").to_f)/100)+1
  end

  def gross_profitability
    (@bid.rate)
  end

  def net_profitability

  end

  def gross_profitability_cdi
    (@bid.rate)/cdi
  end

  def net_profitability_cdi

  end
end
