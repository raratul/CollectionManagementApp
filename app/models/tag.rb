class Tag < ApplicationRecord
    has_many :taggings, dependent: :destroy
    has_many :tagged_items, through: :taggings, source: :taggable, source_type: 'Item'
end
  