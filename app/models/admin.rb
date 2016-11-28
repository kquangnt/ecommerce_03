class Admin < ApplicationRecord
  devise :database_authenticatable, :timeoutable

  validates :name, presence: true, length: {maximum: Settings.maximum_name}
end
