class Item < ApplicationRecord
  belongs_to :collection
  has_many :comments, dependent: :destroy
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  validates :name, presence: true

  def custom_field_values
    values = {}
    (1..3).each do |i|
      values["custom_string#{i}_value"] = send("custom_string#{i}_value") if collection.send("custom_string#{i}_state")
      values["custom_int#{i}_value"] = send("custom_int#{i}_value") if collection.send("custom_int#{i}_state")
      values["custom_text#{i}_value"] = send("custom_text#{i}_value") if collection.send("custom_text#{i}_state")
      values["custom_bool#{i}_value"] = send("custom_bool#{i}_value") if collection.send("custom_bool#{i}_state")
      values["custom_date#{i}_value"] = send("custom_date#{i}_value") if collection.send("custom_date#{i}_state")
    end
    values
  end
end
