module Animals
  module ParamsValidators
    class Update
      attr_accessor :params

      def initialize(params)
        @params = params
      end

      def execute
        required_and_permitted_params
      end

      private

      def required_and_permitted_params
        required_params

        params.require(:animal).permit(generic_params)
      end

      def required_params
        params.require(:animal).tap do |animal_params|
          animal_params.require(generic_params)
        end
      end

      def generic_params
        %i(name age breed weight animal_type joined_at)
      end
    end
  end
end
