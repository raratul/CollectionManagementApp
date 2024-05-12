class Item < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_name_and_tags,
                  against: [:name, :tags],
                  using: {
                    tsearch: { prefix: true }
                  }
  belongs_to :collection
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :users_who_liked, through: :likes, source: :user
end

