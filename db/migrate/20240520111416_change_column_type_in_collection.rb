class ChangeColumnTypeInCollection < ActiveRecord::Migration[7.1]
  def change
    change_column :collections, :custom_bool2_name, :string
    change_column :collections, :custom_bool3_name, :string
  end
end
