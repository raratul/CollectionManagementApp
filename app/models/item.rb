class Item < ApplicationRecord
  belongs_to :collection
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  serialize :custom_fields, Hash
end
