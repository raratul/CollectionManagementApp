class UpdateForeignKeysForCascadeDelete < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :collections, :users
    remove_foreign_key :items, :collections
    remove_foreign_key :comments, :items
    remove_foreign_key :comments, :users
    remove_foreign_key :likes, :items
    remove_foreign_key :likes, :users

    add_foreign_key :collections, :users, on_delete: :cascade
    add_foreign_key :items, :collections, on_delete: :cascade
    add_foreign_key :comments, :items, on_delete: :cascade
    add_foreign_key :comments, :users, on_delete: :cascade
    add_foreign_key :likes, :items, on_delete: :cascade
    add_foreign_key :likes, :users, on_delete: :cascade
  end

end
