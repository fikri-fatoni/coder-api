class Article < ApplicationRecord
  belongs_to :category

  validates :title, :description, :author, :category, presence: true
end
