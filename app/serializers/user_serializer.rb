class UserSerializer < ActiveModel::Serializer
  
  attributes :id, :name, :email, :mobile_number, :created_at, :updated_at, :disabled, :tags

  def tags
    object.user_tags&.pluck(:tag_id)
  end
end