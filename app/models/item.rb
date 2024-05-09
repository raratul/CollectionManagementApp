class Item < ApplicationRecord
  belongs_to :collection
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :users_who_liked, through: :likes, source: :user
end
