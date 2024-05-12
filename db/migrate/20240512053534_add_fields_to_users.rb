class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string
    add_column :users, :last_login_at, :datetime
    add_column :users, :registered_at, :datetime
    add_column :users, :status, :string
  end
end
