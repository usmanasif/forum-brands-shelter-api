module Animals
  module ParamsValidators
    class Adopt
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

        params.require(:guardian).permit(generic_params)
      end

      def required_params
        params.require(:guardian).tap do |guardian_params|
          guardian_params.require(generic_params)
        end
      end

      def generic_params
        %i(full_name email country city address adopted_at)
      end
    end
  end
end
