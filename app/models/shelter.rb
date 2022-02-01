class Shelter < ApplicationRecord
  has_many :animals, dependent: :destroy

  validates :country, :city, :address, presence: true
end
