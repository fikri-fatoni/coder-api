class Forum::IndexSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :image, :like, :category,
             :user, :created_at, :updated_at

  def image
    image = object.try(:image)
    return if image.nil?

    { url: image.try(:url) }
  end

  def category
    category = object.try(:category)
    {
      id: category.try(:id),
      name: category.try(:name)
    }
  end

  def user
    user = object.try(:user)
    {
      id: user.try(:id),
      first_name: user.try(:first_name),
      last_name: user.try(:last_name),
      avatar: { url: user.try(:avatar).url }
    }
  end
end
