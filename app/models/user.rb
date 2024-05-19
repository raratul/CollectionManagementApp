class User < ApplicationRecord
  has_many :collections, dependent: :destroy
  has_many :items, through: :collections
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
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

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable
end
