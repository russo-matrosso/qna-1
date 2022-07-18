class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i[github vkontakte]

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :awards
  has_many :votes, dependent: :destroy
  has_many :authorizations, dependent: :destroy

  def author?(smth)
    id == smth.user_id
  end

  def self.find_for_oauth(auth)
    Services::FindForOauth.new(auth).call
  end

  def create_autorization(auth)
    authorizations.create(provider: auth.provider, uid: auth.uid)
  end
end
