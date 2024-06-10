class Collection < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: [:name, :category, :description, :custom_string1_name, :custom_string2_name, :custom_string3_name,
                                            :custom_text1_name, :custom_text2_name, :custom_text3_name],
                           using: {
                             tsearch: { prefix: true }
                           }

  belongs_to :user
  has_many :items, dependent: :destroy
  has_many_attached :images

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :category, presence: true

  has_many :tickets, dependent: :destroy

  CATEGORIES = %w[Books Signs Silverware Other].freeze

  def custom_fields
    fields = {}
    (1..3).each do |i|
      fields["custom_string#{i}_name"] = send("custom_string#{i}_name") if send("custom_string#{i}_state")
      fields["custom_int#{i}_name"] = send("custom_int#{i}_name") if send("custom_int#{i}_state")
      fields["custom_text#{i}_name"] = send("custom_text#{i}_name") if send("custom_text#{i}_state")
      fields["custom_bool#{i}_name"] = send("custom_bool#{i}_name") if send("custom_bool#{i}_state")
      fields["custom_date#{i}_name"] = send("custom_date#{i}_name") if send("custom_date#{i}_state")
    end
    fields
  end
end
