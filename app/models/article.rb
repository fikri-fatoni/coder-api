class Article < ApplicationRecord
  belongs_to :category

  mount_uploader :image, ImageUploader

  validates :title, :description, :author, presence: true
end
