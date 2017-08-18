module ApplicationHelper
  def cdi
    site_cetip = Nokogiri::HTML(open("https://www.cetip.com.br/").read)
    cdi = site_cetip.search('.txt-taxa-porcentagem span').text.to_d
  end

  def time_to_maturity
    (@security.maturity - Time.current.to_date).to_i
  end
end
