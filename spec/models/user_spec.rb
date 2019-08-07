require 'rails_helper'
describe User do
  describe '#create' do
    #email
    it "emailが空の場合、登録できない" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "emailが既に存在する場合、登録できない" do
      user = create(:user, email: "test@test.com")
      user = build(:user, email: "test@test.com")
      user.valid?
      expect(user.errors[:email]).to include("はすでに存在します")
    end

    #password
    it "passwordが空の場合、登録できない" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "passwordがpassword_confirmationと異なる場合、登録できない" do
      user = build(:user, password: "aaaaaa", password_confirmation: "bbbbbb")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    it "passwordが5文字以下の場合、登録できない" do
      user = build(:user, password: "aaaaa")
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end

    it "passwordが6文字以上128文字以下の場合、登録できる" do
      user = build(:user, password: "aaaaaa")
      user.valid?
      expect(user).to be_valid
    end

    it "passwordが6文字以上128文字以下の場合、登録できる" do
      user = build(:user, password: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
      user.valid?
      expect(user).to be_valid
    end

    it "passwordが129文字以上の場合、登録できない" do
      user = build(:user, password: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
      user.valid?
      expect(user.errors[:password]).to include("は128文字以内で入力してください")
    end

    #nickname
    it "nicknameが空の場合、登録できない" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "nicknameが21文字以上の場合、登録できない" do
      user = build(:user, nickname: "aaaaaaaaaaaaaaaaaaaaa")
      user.valid?
      expect(user.errors[:nickname]).to include("は20文字以内で入力してください")
    end

    it "nicknameが20文字以下の場合、登録できる" do
      user = build(:user, nickname: "aaaaaaaaaaaaaaaaaaaa")
      user.valid?
      expect(user).to be_valid
    end

    #firstname
    it "firstnameが空の場合、登録できない" do
      user = build(:user, firstname: nil)
      user.valid?
      expect(user.errors[:firstname]).to include("を入力してください")
    end

    it "firstnameが全角ではない場合、登録できない" do
      user = build(:user, firstname: "aaa")
      user.valid?
      expect(user.errors[:firstname]).to include("は不正な値です")
    end

    #lastname
    it "lastnameが空の場合、登録できない" do
      user = build(:user, lastname: nil)
      user.valid?
      expect(user.errors[:lastname]).to include("を入力してください")
    end

    it "lastnameが全角ではない場合、登録できない" do
      user = build(:user, lastname: "aaa")
      user.valid?
      expect(user.errors[:lastname]).to include("は不正な値です")
    end

    #firstname_kana
    it "firstname_kanaが空の場合、登録できない" do
      user = build(:user, firstname_kana: nil)
      user.valid?
      expect(user.errors[:firstname_kana]).to include("を入力してください")
    end

    it "firstname_kanaがカタカナではない場合、登録できない" do
      user = build(:user, firstname_kana: "あああ")
      user.valid?
      expect(user.errors[:firstname_kana]).to include("は不正な値です")
    end

    #lastname_kana
    it "lastname_kanaが空の場合、登録できない" do
      user = build(:user, lastname_kana: nil)
      user.valid?
      expect(user.errors[:lastname_kana]).to include("を入力してください")
    end

    it "lastname_kanaがカタカナではない場合、登録できない" do
      user = build(:user, lastname_kana: "あああ")
      user.valid?
      expect(user.errors[:lastname_kana]).to include("は不正な値です")
    end

    #birthday
    it "birthdayが空の場合、登録できない" do
      user = build(:user, birthday: nil)
      user.valid?
      expect(user.errors[:birthday]).to include("を入力してください")
    end

    #tel
    it "telが空の場合、登録できない" do
      user = build(:user, tel: nil)
      user.valid?
      expect(user.errors[:tel]).to include("は不正な値です")
    end

    it "telが9桁以下の場合、登録できない" do
      user = build(:user, tel: "080000000")
      user.valid?
      expect(user.errors[:tel]).to include("は不正な値です")
    end

    it "telが10桁の場合、登録できる" do
      user = build(:user, tel: "0800000000")
      user.valid?
      expect(user).to be_valid
    end

    it "telが11桁の場合、登録できる" do
      user = build(:user, tel: "08000000000")
      user.valid?
      expect(user).to be_valid
    end

    it "telが12桁以上の場合、登録できない" do
      user = build(:user, tel: "080000000000")
      user.valid?
      expect(user.errors[:tel]).to include("は不正な値です")
    end

    it "telが既に存在する場合、登録できない" do
      user = create(:user, tel: "08000000000")
      user = build(:user, tel: "08000000000")
      user.valid?
      expect(user.errors[:tel]).to include("はすでに存在します")
    end

    #customer
    it "customerが空の場合、登録できない" do
      user = build(:user, customer: nil)
      user.valid?
      expect(user.errors[:customer]).to include("を入力してください")
    end

    #card
    it "cardが空の場合、登録できない" do
      user = build(:user, card: nil)
      user.valid?
      expect(user.errors[:card]).to include("を入力してください")
    end

    #全項目
    it "全項目が適切に入力されている場合（factories/users.rb参照）、登録できる" do
      user = build(:user)
      user.valid?
      expect(user).to be_valid
    end
  end
end