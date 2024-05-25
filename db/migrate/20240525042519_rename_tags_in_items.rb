class RenameTagsInItems < ActiveRecord::Migration[7.1]
  def change
    rename_column :items, :tags, :tag
  end
end
