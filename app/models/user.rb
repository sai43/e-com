class User < ApplicationRecord

  has_many :orders, dependent: :destroy
  has_many :todos, foreign_key: :created_by

  # attr_accessor :remember_token, :activation_token, :reset_token
  # before_save { email.downcase! }
  # before_save { self.email = email.downcase }
  # before_create :create_activation_digest

  # validates :name, presence: true, length: { maximum: 50 }
  # validates :email, presence: true, length: { maximum: 255 }, email: true,
  #           format: /@/,
  #           uniqueness: { case_sensitive: false }
  # validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # encrypt password
  has_secure_password

  validates_presence_of :name, :email, :password_digest


  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def self.search(search)
    where('name LIKE ? AND activated = ?', "%#{search}%", true)
  end


end
