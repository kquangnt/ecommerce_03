module OrdersHelper
  def display_cost
    number_to_currency(@order.cost, unit: "") + t("vnd")
  end
end
