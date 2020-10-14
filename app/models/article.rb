class Article < ApplicationRecord
  belongs_to :category

  validates :title, :description, :author, presence: true
end
