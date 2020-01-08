require 'rails_helper'

describe StreetAddress do
  describe '#create' do
    # let(:user){create(:user)}

    it "is valid with a address_last_name, address_first_name, address_first_name_kana, address_last_name_kana, post_number, prefectures, city, house_number," do
      streetaddress = build(:street_address)
      expect(streetaddress).to be_valid
    end
    
    it "is invalid without a address_last_name" do
      streetaddress = build(:street_address, address_last_name: "")
      streetaddress.valid?
      expect(streetaddress.errors[:address_last_name]).to include("can't be blank")
    end

    it "is invalid without a address_first_name" do
      streetaddress = build(:street_address, address_first_name: "")
      streetaddress.valid?
      expect(streetaddress.errors[:address_first_name]).to include("can't be blank")
    end

    it "is invalid without a address_last_name_kana" do
      streetaddress = build(:street_address, address_last_name_kana: "")
      streetaddress.valid?
      expect(streetaddress.errors[:address_last_name_kana]).to include("can't be blank")
    end

    it "is invalid without a address_first_name_kana" do
      streetaddress = build(:street_address, address_first_name_kana: "")
      streetaddress.valid?
      expect(streetaddress.errors[:address_first_name_kana]).to include("can't be blank")
    end

    it "is invalid without a post_number" do
      streetaddress = build(:street_address, post_number: "")
      streetaddress.valid?
      expect(streetaddress.errors[:post_number]).to include("can't be blank")
    end

    it "is invalid without a prefectures" do
      streetaddress = build(:street_address, prefectures: "")
      streetaddress.valid?
      expect(streetaddress.errors[:prefectures]).to include("can't be blank")
    end

    it "is invalid without a city" do
      streetaddress = build(:street_address, city: "")
      streetaddress.valid?
      expect(streetaddress.errors[:city]).to include("can't be blank")
    end

    it "is invalid without a house_number" do
      streetaddress = build(:street_address, house_number: "")
      streetaddress.valid?
      expect(streetaddress.errors[:house_number]).to include("can't be blank")
    end
  end
end