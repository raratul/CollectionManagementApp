class Item < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: [:name, :custom_string1_value, :custom_string2_value, :custom_string3_value, 
                                            :custom_text1_value, :custom_text2_value, :custom_text3_value, :tag],
                           associated_against: {
                             comments: [:body]
                           },
                           using: {
                             tsearch: { prefix: true }
                           }

  belongs_to :collection
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_by_users, through: :likes, source: :user

  validates :name, presence: true

  def liked_by?(user)
    likes.exists?(user: user)
  end

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
