module Animals
  class Adopt
    attr_accessor :animal_id, :permitted_params

    def initialize(animal_id, params)
      @animal_id = animal_id
      @permitted_params = Animals::ParamsValidators::Adopt.new(params).execute
    end

    def execute
      ActiveRecord::Base.transaction do
        animal.update!(adopted: true, adopted_at: permitted_params[:adopted_at], guardian_id: guardian.id)

        animal
      end
    end

    private

    def guardian
      @guardian ||= Guardian.create!(permitted_params.except(:adopted_at))
    end

    def animal
      @animal ||= Animal.find(animal_id)
    end
  end
end
