require 'rails_helper'

describe Creditcard do
  describe '#create' do

    it "is valid with a card_id, customer_id," do
      creditcard = build(:creditcard)
      expect(creditcard).to be_valid
    end
    
    it "is invalid without a card_id" do
      creditcard = build(:creditcard, card_id: "")
      creditcard.valid?
      expect(creditcard.errors[:card_id]).to include("can't be blank")
    end

    it "is invalid without a customer_id" do
      creditcard = build(:creditcard, customer_id: "")
      creditcard.valid?
      expect(creditcard.errors[:customer_id]).to include("can't be blank")
    end
  end
end