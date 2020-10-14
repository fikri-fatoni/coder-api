class Mentor < ApplicationRecord
  has_many :shcedules

  validates :first_name, :expertise, :email, presence: true
end
