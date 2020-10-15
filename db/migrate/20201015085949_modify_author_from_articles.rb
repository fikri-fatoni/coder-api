class ModifyAuthorFromArticles < ActiveRecord::Migration[6.0]
  def change
    remove_column :articles, :author
    add_column :articles, :author_id, :integer
  end
end
