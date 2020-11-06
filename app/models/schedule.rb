class Schedule < ApplicationRecord
  resourcify
  extend Enumerize

  belongs_to :category
  belongs_to :mentor, class_name: 'User'
  has_and_belongs_to_many :rewards

  validates :title, :description, :google_form_link, :event_date, :schedule_type, :status, presence: true

  enumerize :schedule_type, in: %i[workshop seminar academy]
  enumerize :status, in: %i[finish ongoing coming]

  def add_reward(reward_id)
    reward = Reward.find(reward_id)
    return if rewards.pluck(:id).include?(reward.id)

    rewards << reward
  end

  def remove_reward(reward_id)
    reward = Reward.find(reward_id)
    return unless rewards.include?(reward)

    rewards.delete(reward)
  end
end
