class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :programming_skill
      t.date :date_of_birth

      t.timestamps
    end
  end
end
