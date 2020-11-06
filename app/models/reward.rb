class Reward < ApplicationRecord
  has_and_belongs_to_many :schedules

  validates :name, presence: true
end
