devise :database_authenticatable,
       :registerable,
       :recoverable,
       :rememberable,
       :validatable,
       :trackable,
       :confirmable,
       :lockable,
       :omniauthable,
       omniauth_providers: %i[facebook google]

after_create :assign_default_role

def assign_default_role
  add_role(:user) if roles.blank?
end

def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    process_user(user, auth)
    user.skip_confirmation!
  end
end

def self.process_user(user, auth)
  info = auth.info

  user.email = info.email
  user.password = Devise.friendly_token[0, 20]
  user.first_name = info.first_name
  user.last_name = info.last_name
end
