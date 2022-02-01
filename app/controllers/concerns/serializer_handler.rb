module SerializerHandler
  def serialize(collection, serializer, record = nil)
    return {} if collection.blank?

    ActiveModelSerializers::SerializableResource.new(collection,
                                                     each_serializer: serializer,
                                                     adapter: :json,
                                                     data: record)
                                                .as_json
  end
end
