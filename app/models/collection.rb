class Collection < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy
  has_many :user_collections, dependent: :destroy
  has_many :users, through: :user_collections

  def custom_fields
  end
  serialize :custom_fields, JSON
end
