class Category < ApplicationRecord
  has_many :articles

  validates :name, :description, presence: true
end
