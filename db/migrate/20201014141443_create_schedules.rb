class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.string :title
      t.string :description
      t.string :google_form_link
      t.string :type
      t.string :status
      t.string :learning_tool
      t.datetime :event_date
      t.integer :category_id
      t.integer :mentor_id

      t.timestamps
    end
  end
end
