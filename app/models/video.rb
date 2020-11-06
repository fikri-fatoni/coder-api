class Video < ApplicationRecord
  resourcify

  belongs_to :category
  belongs_to :mentor, class_name: 'User'

  mount_uploader :thumbnail, ImageUploader

  validates :title, :description, :video_link, presence: true
end
