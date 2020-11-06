class CreateRewardsSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :rewards_schedules, id: false do |t|
      t.belongs_to :reward
      t.belongs_to :schedule
    end
  end
end
