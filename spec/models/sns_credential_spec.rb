require 'rails_helper'

describe SnsCredential do
  describe '#create' do

    it "is valid with a uid, provider," do
      snscredential = build(:sns_credential)
      expect(snscredential).to be_valid
    end
    
    it "is invalid without a uid" do
      snscredential = build(:sns_credential, uid: "")
      snscredential.valid?
      expect(snscredential.errors[:uid]).to include("can't be blank")
    end

    it "is invalid without a provider" do
      snscredential = build(:sns_credential, provider: "")
      snscredential.valid?
      expect(snscredential.errors[:provider]).to include("can't be blank")
    end
  end
end
