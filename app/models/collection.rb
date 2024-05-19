class Collection < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy
  has_many_attached :images

  validates :name, presence: true
  validates :category, presence: true

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
