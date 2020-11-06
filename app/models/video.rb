class Video < ApplicationRecord
  resourcify
  extend Enumerize

  belongs_to :category
  belongs_to :mentor, class_name: 'User'

  mount_uploader :thumbnail, ImageUploader

  validates :title, :description, :video_link, :video_type, presence: true

  enumerize :video_type, in: %i[free premium]
end
