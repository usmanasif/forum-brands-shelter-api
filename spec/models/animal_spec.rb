require 'rails_helper'

RSpec.describe Animal, type: :model do
  describe 'associations' do
    it { should belong_to(:shelter) }
    it { should belong_to(:guardian).optional }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_presence_of(:breed) }
    it { should validate_presence_of(:weight) }
    it { should validate_presence_of(:animal_type) }
    it { should validate_presence_of(:joined_at) }
    it { should validate_numericality_of(:age).only_integer.is_greater_than(0) }
    it { should validate_numericality_of(:weight).is_greater_than(0.0) }

    context 'custom validations' do
      let!(:cat) { FactoryBot.create(:animal, :cat) }
      invalid_adopted_date_message = I18n.t('animal.attributes.adopted_at.invalid_with_respect_to_joining_date')

      it 'should ensure adoption date is not present when the animal is created' do
        expect(cat.adopted_at).to(be_nil)
      end

      it 'should return valid error message when adoption date is invalid with respect to the joining date' do
        cat.adopted_at = cat.joined_at - 1.days
        cat.save

        expect(cat.errors.full_messages).to(include(invalid_adopted_date_message))
      end

      it 'should ensure valid adoption date with respect to the joining date' do
        cat.adopted_at = DateTime.current

        expect(cat.adopted_at).to(be >= cat.joined_at)
      end
    end
  end
end
