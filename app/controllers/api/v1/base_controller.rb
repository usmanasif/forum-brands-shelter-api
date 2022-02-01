module Api
  module V1
    class BaseController < ApplicationController
      include BaseHandler
      include SerializerHandler

      def index
        raise ActiveRecord::RecordNotFound, controller_name.camelize.singularize if relation.blank?

        render json: serialize(collection, serializer)
      end

      def create
        if new_resource.save
          render json: new_resource, each_serializer: serializer, status: :created
        else
          render json: { message: new_resource.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def show
        render json: resource
      end

      def update
        if resource.update(permitted_params)
          render json: resource, each_serializer: serializer
        else
          render json: { message: resource.errors.full_messages }, status: :unprocessable_entity
        end
      end

      protected

      def collection
        @collection ||= BaseCollection.new(relation, filter_params).results
      end

      def relation
        @relation ||= model.all
      end

      def filter_params
        params.permit
      end

      def new_resource
        @new_resource ||= model.new(permitted_params)
      end

      def resource
        @resource ||= model.find(params[:id])
      end

      def permitted_params; end

      def serializer
        "#{model.name}Serializer".constantize
      end
    end
  end
end
