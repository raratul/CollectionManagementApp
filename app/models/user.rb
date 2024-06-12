class User < ApplicationRecord
  has_many :collections, dependent: :destroy
  has_many :items, through: :collections
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_items, through: :likes, source: :item

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :theme, inclusion: { in: %w[light dark], message: "%{value} is not a valid theme" }, allow_nil: true
  validates :language, inclusion: { in: %w[en pl], message: "%{value} is not a valid language" }, allow_nil: true

  has_many :tickets, dependent: :destroy

  before_create :generate_api_token

  def generate_api_token
    loop do
      self.api_token = SecureRandom.hex(20)
      break unless User.exists?(api_token: api_token)
    end
  end

  def regenerate_api_token
    generate_api_token
    save
  end

  def self.first_admin?
    where(admin: true).count.zero?
  end

  def active_for_authentication?
    super && !blocked?
  end

  def inactive_message
    !blocked? ? super : :blocked
  end

  def likes?(item)
    liked_items.include?(item)
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :omniauthable, omniauth_providers: %i[facebook]

         def self.from_omniauth(auth)
          where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.email = auth.info.email
            user.password = Devise.friendly_token[0, 20]
            user.name = auth.info.name
          end
        end
end
