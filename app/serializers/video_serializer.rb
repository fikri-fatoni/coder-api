class VideoSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :thumbnail, :video_link,
             :category, :mentor, :created_at, :updated_at

  def thumbnail
    thumbnail = object.try(:thumbnail)
    return if thumbnail.nil?

    { url: thumbnail.try(:url) }
  end

  def category
    category = object.try(:category)
    {
      id: category.try(:id),
      name: category.try(:name)
    }
  end

  def mentor
    mentor = object.try(:mentor)
    {
      id: mentor.try(:id),
      first_name: mentor.try(:first_name),
      last_name: mentor.try(:last_name),
      avatar: { url: mentor.try(:avatar).url }
    }
  end

  def created_at
    object.try(:created_at).in_time_zone(Time.zone).strftime('%d-%m-%Y %T %Z')
  end

  def updated_at
    object.try(:updated_at).in_time_zone(Time.zone).strftime('%d-%m-%Y %T %Z')
  end
end
