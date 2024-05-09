class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :tags
      t.string :author
      t.references :collection, null: false, foreign_key: true

      t.timestamps
    end
  end
end
