class Article < ApplicationRecord
  resourcify

  belongs_to :category
  belongs_to :author, class_name: 'User'

  mount_uploader :image, ImageUploader

  validates :title, :description, presence: true
end
