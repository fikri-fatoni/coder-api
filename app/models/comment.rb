class Comment < ApplicationRecord
  resourcify

  belongs_to :forum
  belongs_to :user

  validates :body, presence: true
end
