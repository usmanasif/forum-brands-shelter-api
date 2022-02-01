class Animal < ApplicationRecord
  belongs_to :shelter
  belongs_to :guardian, optional: true

  validates :name, :age, :breed, :weight, :animal_type, :joined_at, presence: true
  validates :age, numericality: { only_integer: true, greater_than: 0 }
  validates :weight, numericality: { greater_than: 0.0 }
  validate :adoption_and_joining_date

  enum animal_type: { cat: 0, dog: 1 }

  private

  def adoption_and_joining_date
    return true if adopted_at.blank? || adopted_at >= joined_at

    errors.add(:base, I18n.t('animal.attributes.adopted_at.invalid_with_respect_to_joining_date'))

    false
  end
end
