module Api
  module V1
    class AnimalsController < BaseController
      actions :index, :show, :update

      def adopt
        adopted_animal = ::Animals::Adopt.new(params[:id], params).execute

        render json: adopted_animal
      end

      private

      def collection
        @collection ||= ::AnimalsCollection.new(relation, filter_params).results
      end

      def relation
        @relation ||= ::Animal.includes(:shelter)
      end

      def filter_params
        params.permit(:animal_type)
      end

      def permitted_params
        ::Animals::ParamsValidators::Update.new(params).execute
      end
    end
  end
end
