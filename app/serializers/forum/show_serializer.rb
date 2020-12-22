class Forum::ShowSerializer < ActiveModel::Serializer
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

  def created_at
    object.try(:created_at).in_time_zone(Time.zone).strftime('%d-%m-%Y %T %Z')
  end

  def updated_at
    object.try(:updated_at).in_time_zone(Time.zone).strftime('%d-%m-%Y %T %Z')
  end
end
