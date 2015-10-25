class User
  include MongoMapper::Document

  before_save :set_auth_token

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Had to manually add schema since it isn't pulled in automatically
  # See https://github.com/plataformatec/devise/wiki/How-To:-Upgrade-to-Devise-2.0-migration-schema-style

  key :authentication_token, String, :null => false

  ## Database authenticatable
  key :email, String, :null => false
  key :encrypted_password, String, :null => false

  ## Recoverable
  key :reset_password_token,   String
  key :reset_password_sent_at, Time

  ## Rememberable
  key :remember_created_at, Time

  ## Trackable
  key :sign_in_count,      Integer
  key :current_sign_in_at, Time
  key :last_sign_in_at,    Time
  key :current_sign_in_ip, String
  key :last_sign_in_ip,    String

  private
  def set_auth_token
    # @TODO This is insecure, don't authenticate with the same token every time. Scramble upon login
    if self.authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
