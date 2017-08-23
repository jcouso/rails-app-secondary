module ApplicationHelper

  def gross_profitability
    (@bid.rate.to_f)
  end

  def net_profitability
    if @security.time_to_maturity <= 180
      (@bid.rate.to_f * 0.775)
    elsif @security.time_to_maturity <= 360
      (@bid.rate.to_f * 0.8)
    elsif @security.time_to_maturity <= 720
      (@bid.rate.to_f * 0.825)
    else
      (@bid.rate.to_f * 0.85)
    end
  end

  def gross_profitability_cdi
    (gross_profitability.to_f / @security.cdi)
  end

  def net_profitability_cdi
    (net_profitability.to_f / @security.cdi)
  end

  def price_calc
    n = (@security.time_to_maturity.to_f) * (360.to_f/365)
    i_dia = ((@bid.rate.to_f / 100)+1)**(1.to_f/360)
    @bid.price = (hp12c_fv.to_f / ((i_dia.to_f)**(n)))
    @bid.price
  end

  def rate_calc

  end

  def hp12c_fv
    n = (@security.time_to_maturity.to_f + @security.time_elapsed.to_f) * (360.to_f/365)
    pv = @security.value
    i_dia = ((@security.hp12c_interest.to_f / 100)+1)**(1.to_f/360)
    fv = pv.to_f * ((i_dia.to_f)**(n.to_f))
    fv
  end
end
