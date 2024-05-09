class CreateCollections < ActiveRecord::Migration[7.1]
  def change
    create_table :collections do |t|
      t.string :name
      t.text :description
      t.string :topic
      t.string :image
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
