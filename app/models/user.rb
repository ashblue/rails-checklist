class User
  include MongoMapper::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Had to manually add schema since it isn't pulled in automatically
  # See https://github.com/plataformatec/devise/wiki/How-To:-Upgrade-to-Devise-2.0-migration-schema-style

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

end
