class DropTableMentor < ActiveRecord::Migration[6.0]
  def change
    drop_table :mentors
  end
end
