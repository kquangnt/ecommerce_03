module CartsHelper
  def display_total_price price
    number_to_currency(price, unit: "#{t("vnd")}", format: "%n %u")
  end
end
