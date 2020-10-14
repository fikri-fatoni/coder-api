class AddInformationsToUser < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :programming_skill
      t.date   :date_of_birth
    end
  end
end
