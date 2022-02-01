class Guardian < ApplicationRecord
  has_many :animals, dependent: :destroy

  validates :full_name, :email, :country, :city, :address, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
