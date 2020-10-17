class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :username, :email,
             :phone_number, :date_of_birth, :programming_skill,
             :avatar

  def date_of_birth
    object.try(:date_of_birth).in_time_zone(Time.zone).strftime('%d-%m-%Y')
  end

  def avatar
    avatar = object.try(:avatar)
    { url: avatar.try(:url) }
  end
end
