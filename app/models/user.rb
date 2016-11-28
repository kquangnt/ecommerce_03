class User < ApplicationRecord
  has_many :reviews
  has_many :orders, dependent: :destroy

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, length: {maximum: Settings.maximum_name}
  validates :telephone, presence: true

  scope :order_date_desc, ->{order created_at: :desc}
end
