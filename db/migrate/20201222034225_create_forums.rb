class CreateForums < ActiveRecord::Migration[6.0]
  def change
    create_table :forums do |t|
      t.string :title
      t.string :body
      t.string :image
      t.integer :like
      t.integer :user_id
      t.integer :category_id

      t.timestamps
    end
  end
end
