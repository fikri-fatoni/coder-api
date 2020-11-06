class RenameAuthorToMentorVideo < ActiveRecord::Migration[6.0]
  def change
    rename_column :videos, :author_id, :mentor_id
  end
end
