class MentorSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :description, :expertise, :email
end
