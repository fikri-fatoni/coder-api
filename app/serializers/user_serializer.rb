class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :username, :email,
             :phone_number, :date_of_birth, :programming_skill,
             :profession, :avatar, :role

  def date_of_birth
    date_of_birth = object.try(:date_of_birth)
    return if date_of_birth.nil?

    date_of_birth.strftime('%d-%m-%Y')
  end

  def avatar
    avatar = object.try(:avatar)
    return if avatar.nil?

    { url: avatar.try(:url) }
  end

  def role
    role = object.try(:roles).first
    return if role.nil?

    ActiveModel::SerializableResource.new(
      role,
      serializer: RoleSerializer
    )
  end
end
