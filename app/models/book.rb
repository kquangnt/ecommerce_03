class Book < ApplicationRecord
  belongs_to :order_detail
  belongs_to :category
  has_many :reviews

  has_attached_file :book_img, styles: {book_index: Settings.book_index,
    book_show: Settings.book_show, default_url: "/images/:style/missing.png"}
  validates_attachment_content_type :book_img, content_type: /\Aimage\/.*\z/

  validates :title, presence: true
  validates :description, presence: true
  validates :author, presence: true
  validates :unit_price, presence: true
  validates :category_id, presence: true

  scope :order_date_desc, ->{order created_at: :desc}
  scope :filter_category, ->category_id do
    where category_id: category_id
  end
end
