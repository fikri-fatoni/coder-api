class User::IndexSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :first_name, :date_of_birth

  def date_of_birth
    d = object.date_of_birth
    d.strftime('%d-%m-%Y')
  end
end
