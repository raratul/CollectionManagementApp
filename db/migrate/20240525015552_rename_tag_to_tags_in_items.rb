class RenameTagToTagsInItems < ActiveRecord::Migration[7.1]
  def change
    rename_column :items, :tag, :tags
  end
end
