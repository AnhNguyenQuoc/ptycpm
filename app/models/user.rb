class User < ApplicationRecord
  attr_accessor :remember_token
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  before_save {self.email = email.downcase}

  scope :admin, -> {where(role: true)}
  scope :customer, -> {where(role: false)}
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                                                   length: {maximum: 255},
                                                   format: { with: VALID_EMAIL_REGEX }
  validates :phone, :presence => { :message => "can't be blank"}, :numericality =>{ :message => "only number"} , length: {in: 10..11, :message => 'must in 10-11 numbers'}
  validates :address, presence: true, length: {maximum: 50}
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true, on: :create
  has_secure_password


  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST:
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

#Return a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

#Remember a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
