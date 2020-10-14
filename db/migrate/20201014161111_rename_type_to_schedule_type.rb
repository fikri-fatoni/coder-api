class RenameTypeToScheduleType < ActiveRecord::Migration[6.0]
  def change
    rename_column :schedules, :type, :schedule_type
  end
end
