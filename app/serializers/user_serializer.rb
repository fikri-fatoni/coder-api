class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :username, :email,
             :phone_number, :date_of_birth, :programming_skill,
             :avatar
end
