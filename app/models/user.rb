class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:github]

  has_many :stories, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :comment_likes
  has_many :story_likes


  def self.from_omniauth(auth)
      email_match = User.find_by(email: auth.info.email)
      credential_match = User.find_by(provider: auth.provider, uid: auth.uid)
      if credential_match
        credential_match
      elsif email_match
        email_match.update_attributes(uid: auth.uid,provider: auth.provider )
        email_match.reload
      else
        User.create(
          user.provider = auth.provider,
          user.uid = auth.uid,
          user.email = auth.info.email,
          user.password = Devise.friendly_token[0,20]
        )
      end
  end
end
