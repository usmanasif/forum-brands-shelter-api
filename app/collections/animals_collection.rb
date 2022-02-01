class AnimalsCollection < BaseCollection
  private

  def filter_records
    filter_by_animal_type if animal_type.present? && searchable_types.include?(animal_type)
  end

  def filter_by_animal_type
    filter { @relation.send(animal_type) }
  end

  def animal_type
    params[:animal_type]
  end

  def searchable_types
    %w(cat dog)
  end
end
