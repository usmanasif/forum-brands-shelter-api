FactoryBot.define do
  factory :shelter do
    country { Faker::Address.country }
    city { Faker::Address.city }
    address { "#{Faker::Address.city}, #{Faker::Address.country}" }
  end
end
