FactoryBot.define do
  factory :guardian do
    full_name { Faker::Name.name }
    email { Faker::Internet.email }
    address { "#{Faker::Address.city}, #{Faker::Address.country}" }
    country { Faker::Address.country }
    city { Faker::Address.city }
  end
end
