class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :email, :name, :target_weight, :current_weight, :profile_image, :created_at
end