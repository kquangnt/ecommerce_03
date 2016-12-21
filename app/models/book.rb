class Book < ApplicationRecord
  belongs_to :category
  has_many :order_details
  before_destroy :check_if_has_order_detail
  has_many :orders, through: :order_details
  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_attached_file :book_img, styles: {book_index: Settings.book_index,
    book_show: Settings.book_show, default_url: "/images/:style/missing.png"}
  validates_attachment_content_type :book_img, content_type: /\Aimage\/.*\z/

  validates :title, presence: true
  validates :description, presence: true
  validates :author, presence: true
  validates :unit_price, presence: true
  validates :category_id, presence: true

  scope :order_date_desc, ->{order created_at: :desc}
  scope :order_view_count_desc, ->{order view_count: :desc}
  scope :filter_category, ->category_id do
    where category_id: category_id
  end

  def self.search(book_title_input, book_unitprice_input="%", category_input="%")
    where("title LIKE ? AND unit_price LIKE ? AND category_id LIKE ?",
      "%#{book_title_input}%", "#{book_unitprice_input}", category_input)
  end

  private
  def check_if_has_order_detail
    errors.add(:base, t("this_book_has_a_rder_etail")) unless order_details.empty?
  end
end
