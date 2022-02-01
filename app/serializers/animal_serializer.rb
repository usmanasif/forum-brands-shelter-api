class AnimalSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :breed, :weight, :animal_type, :joined_at, :adopted_at, :adopted

  belongs_to :shelter
  belongs_to :guardian
end
