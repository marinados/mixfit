class UserSerializer < ActiveModel::Serializer
  attributes :name, :weight, :height
end