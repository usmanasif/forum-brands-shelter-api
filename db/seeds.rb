shelters = [
  { country: "US", city: "Silicon Valley", address: "Silicon Valley, CA" },
  { country: "US", city: "Los Angeles", address: "Los Angeles, CA" },
  { country: "US", city: "San Francisco", address: "San Francisco, CA" }
]

animals = [
 {
   name: Faker::Creature::Cat.name,
   animal_type: Animal.animal_types.values.first,
   breed: Faker::Creature::Cat.breed,
   age: Faker::Number.between(from: 1, to: 30),
   weight: Faker::Number.between(from: 2, to: 900),
   joined_at: DateTime.current,
   adopted: false
 },
 {
   name: Faker::Creature::Dog.name,
   animal_type: Animal.animal_types.values.second,
   breed: Faker::Creature::Dog.breed,
   age: Faker::Number.between(from: 1, to: 30),
   weight: Faker::Number.between(from: 2, to: 900),
   joined_at: DateTime.current,
   adopted: false
 },
 {
   name: Faker::Creature::Cat.name,
   animal_type: Animal.animal_types.values.first,
   breed: Faker::Creature::Cat.breed,
   age: Faker::Number.between(from: 1, to: 30),
   weight: Faker::Number.between(from: 2, to: 900),
   joined_at: DateTime.current,
   adopted: false
 },
 {
   name: Faker::Creature::Dog.name,
   animal_type: Animal.animal_types.values.second,
   breed: Faker::Creature::Dog.breed,
   age: Faker::Number.between(from: 1, to: 30),
   weight: Faker::Number.between(from: 2, to: 900),
   joined_at: DateTime.current,
   adopted: false
 },
 {
   name: Faker::Creature::Cat.name,
   animal_type: Animal.animal_types.values.first,
   breed: Faker::Creature::Cat.breed,
   age: Faker::Number.between(from: 1, to: 30),
   weight: Faker::Number.between(from: 2, to: 900),
   joined_at: DateTime.current,
   adopted: false
 },
 {
   name: Faker::Creature::Dog.name,
   animal_type: Animal.animal_types.values.second,
   breed: Faker::Creature::Dog.breed,
   age: Faker::Number.between(from: 1, to: 30),
   weight: Faker::Number.between(from: 2, to: 900),
   joined_at: DateTime.current,
   adopted: false
 },
 {
   name: Faker::Creature::Cat.name,
   animal_type: Animal.animal_types.values.first,
   breed: Faker::Creature::Cat.breed,
   age: Faker::Number.between(from: 1, to: 30),
   weight: Faker::Number.between(from: 2, to: 900),
   joined_at: DateTime.current,
   adopted: false
 },
 {
   name: Faker::Creature::Dog.name,
   animal_type: Animal.animal_types.values.second,
   breed: Faker::Creature::Dog.breed,
   age: Faker::Number.between(from: 1, to: 30),
   weight: Faker::Number.between(from: 2, to: 900),
   joined_at: DateTime.current,
   adopted: false
 },
 {
   name: Faker::Creature::Cat.name,
   animal_type: Animal.animal_types.values.first,
   breed: Faker::Creature::Cat.breed,
   age: Faker::Number.between(from: 1, to: 30),
   weight: Faker::Number.between(from: 2, to: 900),
   joined_at: DateTime.current,
   adopted: false
 },
 {
   name: Faker::Creature::Dog.name,
   animal_type: Animal.animal_types.values.second,
   breed: Faker::Creature::Dog.breed,
   age: Faker::Number.between(from: 1, to: 30),
   weight: Faker::Number.between(from: 2, to: 900),
   joined_at: DateTime.current,
   adopted: false
 }
]

shelters.each do |shelter|
  Shelter.create!(shelter)
rescue ActiveRecord::RecordInvalid => e
  puts "Failed to create Shelter with details: #{shelter.as_json}, exception: #{e.message}"
end

animals.each do |animal|
  shelter = Shelter.find(Shelter.pluck(:id).sample)
  shelter.animals.create!(animal)
rescue ActiveRecord::RecordInvalid => e
  puts "Failed to create Animal in the Shelter ID: #{shelter.id} with details: #{animal.as_json}," \
       "exception: #{e.message}"
end
