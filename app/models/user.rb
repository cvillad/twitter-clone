class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets, dependent: :destroy
  validates :username, presence: true, uniqueness: true, format: { with: /^[a-zA-Z0-9_\.]*$/, multiline: true}
  attr_writer :login
  has_one_attached :image, dependent: :destroy 
  validates :image, content_type: ["image/png", "image/jpg", "image/jpeg"]

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication warden_condition
    conditions = warden_condition.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value",
      { value: login.strip.downcase}]).first
  end
end
