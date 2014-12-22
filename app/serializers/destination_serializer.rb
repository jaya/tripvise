class DestinationSerializer < ActiveModel::Serializer
  attributes :city, :state, :country, :full_qualified_name, :picture
end
