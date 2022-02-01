require 'rails_helper'

RSpec.describe Guardian, type: :model do
  describe 'associations' do
    it { should have_many(:animals) }
  end

  describe 'validations' do
    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:address) }

    context 'email validations' do
      it { should allow_value('example@domain.com').for(:email) }
      it { should_not allow_value('example').for(:email) }
    end
  end
end
