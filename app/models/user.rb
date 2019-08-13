class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable,omniauth_providers: [:facebook, :google_oauth2]

  has_one :address, dependent: :destroy
  has_one :sns_credential, dependent: :destroy
  accepts_nested_attributes_for :address
  has_many :items, dependent: :destroy
  has_many :receipts, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, length: {in: 6..128}
  validates :nickname, presence: true, length: {maximum: 20}
  validates :firstname, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :lastname, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :firstname_kana, presence: true, format: { with: /\A([ァ-ン]|ー)+\z/ }
  validates :lastname_kana, presence: true, format: { with: /\A([ァ-ン]|ー)+\z/ }
  validates :birthday, presence: true
  validates :tel, uniqueness: true, format: {with: /\A\d{10}\z|\A\d{11}\z/ } 
  validates :customer, presence: true
  validates :card, presence: true 
  
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