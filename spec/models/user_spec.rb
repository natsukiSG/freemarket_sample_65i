require 'rails_helper'

describe User do
  describe '#create' do
    let(:user){create(:user)}
  
    it "name,name_kana,nickname,email,password,password_confirmation,birthdayが存在すれば登録できること" do
      user = build(:user)
      expect(user).to be_valid
    end
    
    it "nickname未入力では登録できない" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

  
    it "emailが未入力では登録できない" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "first_nameが未入力では登録できない" do
      user = build(:user, first_name: "")
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it "last_nameが未入力では登録できない" do
      user = build(:user, last_name: "")
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
    end

  
    it "first_name_kanaが未入力だと登録できない" do
      user = build(:user, first_name_kana: "")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("can't be blank")
    end

    it "last_name_kanaが未入力では登録できない" do
      user = build(:user, last_name_kana: "")
      user.valid?
      expect(user.errors[:last_name_kana]).to include("can't be blank")
    end

    it " birth_yearが未入力だと登録できない" do
      user = build(:user, birth_year: "")
      user.valid?
      expect(user.errors[:birth_year]).to include("can't be blank")
    end

    it "birth_monthが未入力だと登録できない" do
      user = build(:user, birth_month: "")
      user.valid?
      expect(user.errors[:birth_month]).to include("can't be blank")
    end

    
    it "birth_dayが未入力だと登録できない" do
      user = build(:user, birth_day: "")
      user.valid?
      expect(user.errors[:birth_day]).to include("can't be blank")
    end

    it "電話番号が未入力だと登録できない" do
      user = build(:user, phone_number: "")
      user.valid?
      expect(user.errors[:phone_number]).to include("can't be blank")
    end

    it "パスワードが未入力だと登録できない" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "パスワードが7文字以上ではないと登録できない" do
      user = build(:user, password: "0000000", password_confirmation: "0000000")
      user.valid?
      expect(user).to be_valid
    end

    it "パスワードが6文字以下だと登録できない " do
      user = build(:user, password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user.errors[:password][0]).to include("is too short (minimum is 7 characters)")
    end

    
    it "nicknameが20文字以下なら登録できる" do
      user = build(:user, nickname: "aaaaaaaaaaaaaaaaaaaa")
      user.valid?
      expect(user).to be_valid
    end

  
    it "nicknameが20字以上だと登録できない" do
      user = build(:user, nickname: "aaaaaaaaaaaaaaaaaaaaa")
      user.valid?
      expect(user.errors[:nickname][0]).to include("maximum is 20 characters")
    end

    it "nickname重複、登録できない" do
      another_user = build(:user, nickname: user.nickname)
      another_user.valid?
      expect(another_user.errors[:nickname]).to include("has already been taken")
    end

    
    it "email重複登録できない" do
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    it "電話番号重複登録できない" do
      another_user = build(:user, phone_number: user.phone_number)
      another_user.valid?
      expect(another_user.errors[:phone_number]).to include("has already been taken")
    end

  end
end