require 'rails_helper'

RSpec.describe 'Api::V1::Animals', type: :request do
  describe 'Fetch all Animals' do
    context 'when no animals exist' do
      it 'should give a not found response' do
        get api_v1_animals_path

        expect(response).to have_http_status(:not_found)
      end

      it 'should return proper error message' do
        animals_not_found_message = I18n.t('application.exceptions.record_not_found', resource: 'Animal')
        get api_v1_animals_path

        expect(JSON.parse(response.body)['message']).to include(animals_not_found_message)
      end
    end

    context 'when animals exist and no query paramter is passed' do
      let!(:cat) { FactoryBot.create(:animal, :cat) }

      it 'should return animals array' do
        get api_v1_animals_path

        expect(response).to have_http_status(:success)

        expect(JSON.parse(response.body)['animals'].pluck('id')).to include(cat.id)
      end
    end

    context 'when animals exist and invalid query parameter is passed' do
      let!(:cat) { FactoryBot.create(:animal, :cat) }

      it 'should return animals array' do
        get api_v1_animals_path, params: { type: 'cat' }

        expect(response).to have_http_status(:success)

        expect(JSON.parse(response.body)['animals'].pluck('id')).to include(cat.id)
      end
    end

    context 'when animals exist and valid query parameter is passed' do
      let!(:cats) { FactoryBot.create_list(:animal, 3, :cat) }

      it 'should return cats array' do
        get api_v1_animals_path, params: { animal_type: 'cat' }

        expect(response).to have_http_status(:success)

        animals = JSON.parse(response.body)['animals']

        expect(animals.pluck('id')).to include(cats.first.id)
        expect(animals.pluck('animal_type')).to include('cat')
      end
    end
  end

  describe 'Find a specific animal' do
    context 'when the animal is not found' do
      it 'should give a not found response' do
        get api_v1_animal_path('1')

        expect(response).to have_http_status(:not_found)
      end

      it 'should return proper error message' do
        animals_not_found_message = I18n.t('application.exceptions.record_not_found', resource: 'Animal')
        get api_v1_animal_path('1')

        expect(JSON.parse(response.body)['message']).to include(animals_not_found_message)
      end
    end

    context 'when the animal is found' do
      let!(:cat) { FactoryBot.create(:animal, :cat) }

      it 'should return the animal' do
        get api_v1_animal_path(cat.id)

        expect(response).to have_http_status(:success)

        expect(JSON.parse(response.body)['id']).to eq(cat.id)
      end
    end

    context 'when animals exist and invalid query parameter is passed' do
      let!(:cat) { FactoryBot.create(:animal, :cat) }

      it 'should return animals array' do
        get api_v1_animals_path, params: { type: 'cat' }

        expect(response).to have_http_status(:success)

        expect(JSON.parse(response.body)['animals'].pluck('id')).to include(cat.id)
      end
    end

    context 'when animals exist and valid query parameter is passed' do
      let!(:cats) { FactoryBot.create_list(:animal, 3, :cat) }

      it 'should return cats array' do
        get api_v1_animals_path, params: { animal_type: 'cat' }

        expect(response).to have_http_status(:success)

        animals = JSON.parse(response.body)['animals']

        expect(animals.pluck('id')).to include(cats.first.id)
        expect(animals.pluck('animal_type')).to include('cat')
      end
    end
  end

  describe "Update a specific animal's details" do
    context 'when the animal is not found' do
      it 'should give a not found response' do
        put api_v1_animal_path('1')

        expect(response).to have_http_status(:not_found)
      end

      it 'should return proper error message' do
        animals_not_found_message = I18n.t('application.exceptions.record_not_found', resource: 'Animal')
        put api_v1_animal_path('1')

        expect(JSON.parse(response.body)['message']).to include(animals_not_found_message)
      end
    end

    context 'when the animal is found' do
      context 'when no parameter is provided' do
        let!(:cat) { FactoryBot.create(:animal, :cat) }

        it 'should return proper error message' do
          put api_v1_animal_path(cat.id)

          missing_paramter_message = I18n.t('application.exceptions.missing_parameter', parameters: 'animal')

          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['message']).to include(missing_paramter_message)
        end
      end

      context 'when valid parameters are provided' do
        let!(:cat) { FactoryBot.create(:animal, :cat) }
        let(:payload) do
          {
            animal: {
              name: 'Felix',
              age: cat.age,
              breed: cat.breed,
              weight: cat.weight,
              animal_type: cat.animal_type,
              joined_at: cat.joined_at
            }
          }
        end

        it 'should return updated cat object' do
          put api_v1_animal_path(cat.id), params: payload

          expect(response).to have_http_status(:success)
          expect(JSON.parse(response.body)['name']).to eq('Felix')
        end
      end
    end
  end

  describe 'Adopt a specific animal' do
    context 'when no parameter is provided' do
      let!(:cat) { FactoryBot.create(:animal, :cat) }

      it 'should return proper error message' do
        put adopt_api_v1_animal_path(cat.id)

        missing_paramter_message = I18n.t('application.exceptions.missing_parameter', parameters: 'guardian')

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message']).to include(missing_paramter_message)
      end
    end

    context 'when valid parameters are provided' do
      context 'when the animal is not found' do
        let(:payload) do
          {
            guardian: {
              full_name: Faker::Name.name,
              email: Faker::Internet.email,
              address: "#{Faker::Address.city}, #{Faker::Address.country}",
              country: Faker::Address.country,
              city: Faker::Address.city,
              adopted_at: DateTime.current
            }
          }
        end

        it 'should give a not found response' do
          put adopt_api_v1_animal_path('1'), params: payload

          expect(response).to have_http_status(:not_found)
        end

        it 'should return proper error message' do
          animals_not_found_message = I18n.t('application.exceptions.record_not_found', resource: 'Animal')
          put adopt_api_v1_animal_path('1'), params: payload

          expect(JSON.parse(response.body)['message']).to include(animals_not_found_message)
        end
      end

      context 'when the animal is found' do
        let!(:cat) { FactoryBot.create(:animal, :cat) }
        let(:payload) do
          {
            guardian: {
              full_name: Faker::Name.name,
              email: Faker::Internet.email,
              address: "#{Faker::Address.city}, #{Faker::Address.country}",
              country: Faker::Address.country,
              city: Faker::Address.city,
              adopted_at: cat.joined_at + 1.days
            }
          }
        end

        it 'should return adopted cat object' do
          put adopt_api_v1_animal_path(cat.id), params: payload

          expect(response).to have_http_status(:success)

          adopted_cat = JSON.parse(response.body)

          expect(adopted_cat['adopted']).to be_truthy
          expect(adopted_cat['adopted_at']).not_to be_nil
          expect(adopted_cat.dig('guardian', 'id')).not_to be_nil
        end
      end
    end
  end
end
