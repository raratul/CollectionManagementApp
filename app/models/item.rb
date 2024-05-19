class Item < ApplicationRecord
  belongs_to :collection
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true

  def self.tagged_with(name)
    where("tags @> ARRAY[?]::varchar[]", name)
  end

  def self.tag_counts
    select("unnest(tags) AS tag").group("tag").order("count_all DESC").count
  end

  def all_tags=(names)
    self.tags = names.split(",").map(&:strip)
  end

  def all_tags
    tags.join(", ")
  end
end
