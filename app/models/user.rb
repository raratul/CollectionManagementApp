class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

         has_many :collections
         has_many :items, through: :collections
         has_many :comments
         has_many :likes
         has_many :liked_items, through: :likes, source: :item
         has_many :user_collections
         has_many :collections_managed, through: :user_collections, source: :collection

         validates :name, presence: true
         validates :theme, inclusion: { in: %w[light dark], message: "%{value} is not a valid theme" }, allow_nil: true
         validates :language, inclusion: { in: %w[en pl], message: "%{value} is not a valid language" }, allow_nil: true

         def self.first_admin?
           where(admin: true).count.zero?
         end

         def active_for_authentication?
          super && !blocked?
        end
      
        def inactive_message
          !blocked? ? super : :blocked
        end
end
