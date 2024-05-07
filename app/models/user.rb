class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         
  has_many :collections
  has_many :items, through: :collections
  has_many :comments
  has_many :likes
end
