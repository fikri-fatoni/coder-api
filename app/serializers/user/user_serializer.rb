class User::UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :password, :email, :phone_number,
             :first_name, :last_name, :date_of_birth, :programming_skill

  def date_of_birth
    d = object.date_of_birth
    d.strftime('%d-%m-%Y')
  end
end
