class User < ApplicationRecord
  extend Enumerize

  validates :username, :password, :email, :first_name, :phone_number, :programming_skill, presence: true

  enumerize :programming_skill, in: { beginner: 1, intermediate: 2, advanced: 3, professional: 4, expert: 5 }
end
