class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :collections
         has_many :items, through: :collections
         has_many :comments
         has_many :likes
         has_many :liked_items, through: :likes, source: :item
         has_many :user_collections
         has_many :collections_managed, through: :user_collections, source: :collection


        def self.first_admin?
          where(admin: true).count.zero?
        end
end
