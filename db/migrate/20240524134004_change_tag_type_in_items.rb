class ChangeTagTypeInItems < ActiveRecord::Migration[7.1]
  def change
    remove_column :items, :tag, :string
    add_column :items, :tag, :string, array: true, default: []
  end
end
