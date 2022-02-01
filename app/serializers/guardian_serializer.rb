class GuardianSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :email, :country, :city, :address
end
