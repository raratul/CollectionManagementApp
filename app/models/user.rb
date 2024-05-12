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

         attr_accessor :name, :last_login_at, :status

        def self.first_admin?
          where(admin: true).count.zero?
        end

        # before_validation :set_default_status

        # private
      
        # def set_default_status
        #   self.status ||= 'active'
        # end
end
