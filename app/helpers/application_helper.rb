module ApplicationHelper

  def gross_profitability
    indexer = @bid.indexer || @security.indexer
    if indexer == "PRE"
      @bid.rate.to_f
    elsif indexer == "CDI"
      @bid.rate.to_f * (@security.cdi.to_f/100)
    elsif indexer == "IPC-A+"
      @bid.rate.to_f + @security.ipca
    elsif indexer == "IGP-M+"
      @bid.rate.to_f + @security.igpm
    end
  end

  def net_profitability
    if @security.time_to_maturity <= 180
      (gross_profitability.to_f * 0.775)
    elsif @security.time_to_maturity <= 360
      (gross_profitability.to_f * 0.8)
    elsif @security.time_to_maturity <= 720
      (gross_profitability.to_f * 0.825)
    else
      (gross_profitability.to_f * 0.85)
    end
  end

  def gross_profitability_cdi
    (gross_profitability.to_f / @security.cdi)
  end

  def net_profitability_cdi
    (net_profitability.to_f / @security.cdi)
  end

  def rate_calc
    n = (@security.time_to_maturity.to_f) * (360.to_f/365)
    pv = @bid.price
    @bid.rate = ((((hp12c_fv.to_f / pv)**(1.to_f/n))**(360))-1)*100
    @bid.rate
  end

  def net_rate_calc
    if @security.time_to_maturity <= 180
      (rate_calc.to_f * 0.775)
    elsif @security.time_to_maturity <= 360
      (rate_calc.to_f * 0.8)
    elsif @security.time_to_maturity <= 720
      (rate_calc.to_f * 0.825)
    else
      (rate_calc.to_f * 0.85)

    end
  end

  def hp12c_fv
    n = (@security.time_to_maturity.to_f + @security.time_elapsed.to_f) * (360.to_f/365)
    pv = @security.value
    i_dia = ((@security.hp12c_interest.to_f / 100)+1)**(1.to_f/360)
    fv = pv.to_f * ((i_dia.to_f)**(n.to_f))
    fv
  end
end
