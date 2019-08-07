class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable,
           :omniauthable,omniauth_providers: [:facebook, :google_oauth2]
  
    has_one :address, dependent: :destroy
    accepts_nested_attributes_for :address
    has_many :items, dependent: :destroy
    has_many :receipts, dependent: :destroy
    # has_many :likes, dependent: :destroy
    # has_many :messages, dependent: :destroy
    # has_many :evaluations, dependent: :destroy
  
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: {in: 6..128}
    validates :nickname, presence: true, length: {maximum: 20}
    validates :firstname, presence: true
    validates :lastname, presence: true
    validates :firstname_kana, presence: true
    validates :lastname_kana, presence: true
    validates :birthday, presence: true
    validates :tel, uniqueness: true 
    validates :customer, presence: true, uniqueness: true
  
  def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    if snscredential.present?
      user = User.where(id: snscredential.user_id).first
    else
      user = User.where(email: auth.info.email).first
      if user.present?
        SnsCredential.create(
          uid: uid,
          provider: provider,
          user_id: user.id)
      end
    end
    return user
  end
end