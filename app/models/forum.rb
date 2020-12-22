class Forum < ApplicationRecord
  resourcify

  belongs_to :category
  belongs_to :user
  has_many :comments

  mount_uploader :image, ImageUploader

  validates :title, :body, presence: true
end
