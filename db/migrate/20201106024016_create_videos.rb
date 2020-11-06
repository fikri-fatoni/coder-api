class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :description
      t.string :thumbnail
      t.string :video_link
      t.integer :author_id

      t.timestamps
    end
  end
end
