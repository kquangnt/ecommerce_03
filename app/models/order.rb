class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, through: :cart

  scope :created_desc, ->{order created_at: :desc}
  scope :filter_user, ->user_id {where user_id: user_id}

  def self.to_xls(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |order|
        csv << order.attributes.values_at(*column_names)
      end
    end
  end
end
