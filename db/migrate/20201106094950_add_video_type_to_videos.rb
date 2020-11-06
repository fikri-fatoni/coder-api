class AddVideoTypeToVideos < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :video_type, :string
  end
end
