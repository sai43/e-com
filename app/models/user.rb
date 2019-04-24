class User < ApplicationRecord

  rolify

  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :users_roles
  has_many :orders, dependent: :destroy

  before_save :ensure_authentication_token

  before_save { email.downcase! }
  before_save { self.email = email.downcase }

  validates :email, presence: true,
            length: { maximum: 255 },
            email: true,
            format: /@/,
            uniqueness: { case_sensitive: false }

  # after_save :check_mail

  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  after_create :set_user_type
  # after_create :send_welcome_email

  def check_mail
    @user =  ( User.exists?(email: self.email) ? User.find_by_email(self.email) : User.create(email: self.email, password: self.password, password_confirmation: self.password_confirmation) ) if self.email.presence
  end

  def self.types
    @@types =  OpenStruct.new({
                                  advanced: 'advanced'.freeze,
                                  standard: 'standard'.freeze
                              }).freeze
  end

  scope :active, -> { where(active: true) }

  def standard
    self.user_type == User.types.standard
  end

  def standard?
    standard
  end

  def advanced
    advanced?
  end

  def advanced?
    !standard?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def full_name_or_email
    return email if first_name.blank? && last_name.blank?
    full_name
  end

  alias_method :name, :full_name_or_email
  alias_method :text, :full_name_or_email

  def as_json(options = {})
    super({
              only: [:id, :first_name, :last_name, :email],
              methods: [:full_name_or_email, :name, :text, :standard],
              include: {
                  :users_roles=>{
                      :include=>[:role]
                  }
              }
          }.merge(options))
  end

  def role_for_resource(resource)
    Role.where(resource: resource).first
  end

  def self.search(search)
    where('name LIKE ? AND activated = ?', "%#{search}%", true)
  end

  # Make sure the user has an authentication token
  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private

  def set_user_type
    if self.email =~ /e-com.(com | io)$/
      self.user_type = User.types.advanced
    else
      self.user_type = User.types.standard
    end
  end

  def send_welcome_email
    #Send a welcome email if this user is not in the process of confirming their email
    if accepted_or_not_invited?
      UserMailer.welcome(self)
    end
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

end
