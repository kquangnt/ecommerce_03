class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, through: :cart

  scope :created_desc, ->{order created_at: :desc}
  scope :filter_user, ->user_id {where user_id: user_id}

end
