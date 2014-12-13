class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :fb_id, :fb_token, :email
end
