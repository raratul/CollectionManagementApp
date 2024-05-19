class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :tags
      t.references :collection, null: false, foreign_key: true
      t.string :custom_string1_value
      t.string :custom_string2_value
      t.string :custom_string3_value
      t.integer :custom_int1_value
      t.integer :custom_int2_value
      t.integer :custom_int3_value
      t.text :custom_text1_value
      t.text :custom_text2_value
      t.text :custom_text3_value
      t.boolean :custom_bool1_value
      t.boolean :custom_bool2_value
      t.boolean :custom_bool3_value
      t.date :custom_date1_value
      t.date :custom_date2_value
      t.date :custom_date3_value

      t.timestamps
    end
  end
end
