class UserSerializer < ActiveModel::Serializer
  
  attributes :id, :name, :email, :mobile_number, :created_at, :updated_at, :tags

  def tags
    object.user_tags&.pluck(:id)
  end
end