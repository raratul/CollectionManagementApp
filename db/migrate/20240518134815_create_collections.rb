class CreateCollections < ActiveRecord::Migration[7.1]
  def change
    create_table :collections do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.references :user, null: false, foreign_key: true
      t.string :category
      t.boolean :custom_string1_state
      t.string :custom_string1_name
      t.boolean :custom_string2_state
      t.string :custom_string2_name
      t.boolean :custom_string3_state
      t.string :custom_string3_name
      t.boolean :custom_int1_state
      t.string :custom_int1_name
      t.boolean :custom_int2_state
      t.string :custom_int2_name
      t.boolean :custom_int3_state
      t.string :custom_int3_name
      t.boolean :custom_text1_state
      t.string :custom_text1_name
      t.boolean :custom_text2_state
      t.string :custom_text2_name
      t.boolean :custom_text3_state
      t.string :custom_text3_name
      t.boolean :custom_bool1_state
      t.string :custom_bool1_name
      t.boolean :custom_bool2_state
      t.boolean :custom_bool2_name
      t.boolean :custom_bool3_state
      t.boolean :custom_bool3_name
      t.boolean :custom_date1_state
      t.string :custom_date1_name
      t.boolean :custom_date2_state
      t.string :custom_date2_name
      t.boolean :custom_date3_state
      t.string :custom_date3_name

      t.timestamps
    end
  end
end
