FactoryBot.define do
  factory :animal do
    name { Faker::Creature::Animal.name }
    age { Faker::Number.between(from: 1, to: 30) }
    weight { Faker::Number.between(from: 2, to: 900) }
    joined_at { DateTime.current }
    adopted { false }
    association :shelter

    trait :cat do
      animal_type { Animal.animal_types.values.first }
      breed { Faker::Creature::Cat.breed }
    end

    trait :dog do
      animal_type { Animal.animal_types.values.second }
      breed { Faker::Creature::Dog.breed }
    end
  end
end
