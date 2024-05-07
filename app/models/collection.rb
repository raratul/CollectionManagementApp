class Collection < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy
  serialize :custom_fields, Hash
end
