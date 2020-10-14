class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :description
      t.string :author
      t.string :image

      t.timestamps
    end
  end
end
