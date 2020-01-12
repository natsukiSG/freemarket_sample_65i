require 'rails_helper'

describe Product do
  describe '#create' do

    it "is valid with a name, comment, price, status, costcharge, delivery_way, delivery_area, delivery_date, category_id" do
      product = build(:product)
      expect(product).to be_valid
    end
    
    it "is invalid without a name" do
      product = build(:product, name: "")
      product.valid?
      expect(product.errors[:name]).to include("can't be blank")
    end

    it "is invalid without a comment" do
      product = build(:product, comment: "")
      product.valid?
      expect(product.errors[:comment]).to include("can't be blank")
    end

    it "is invalid without a price" do
      product = build(:product, price: "")
      product.valid?
      expect(product.errors[:price]).to include("can't be blank")
    end

    it "is invalid without a status" do
      product = build(:product, status: "")
      product.valid?
      expect(product.errors[:status]).to include("can't be blank")
    end

    it "is invalid without a costcharge" do
      product = build(:product, costcharge: "")
      product.valid?
      expect(product.errors[:costcharge]).to include("can't be blank")
    end

    it "is invalid without a delivery_way" do
      product = build(:product, delivery_way: "")
      product.valid?
      expect(product.errors[:delivery_way]).to include("can't be blank")
    end

    it "is invalid without a delivery_area" do
      product = build(:product, delivery_area: "")
      product.valid?
      expect(product.errors[:delivery_area]).to include("can't be blank")
    end

    it "is invalid without a delivery_date" do
      product = build(:product, delivery_date: "")
      product.valid?
      expect(product.errors[:delivery_date]).to include("can't be blank")
    end

    it "is invalid without a category_id" do
      product = build(:product, category_id: "")
      product.valid?
      expect(product.errors[:category_id]).to include("can't be blank")
    end

    it "is invalid with a name that has more than 41 characters " do
      product = build(:product, name: "a" * 41)
      product.valid?
      expect(product.errors[:name]).to include("is too long (maximum is 40 characters)")
    end

    it "is valid with a nickname that has less than 40 characters " do
      product = build(:product, name: "a" * 40)
      expect(product).to be_valid
    end

    it "is invalid with a name that has more than 101 characters " do
      product = build(:product, comment: "a" * 101)
      product.valid?
      expect(product.errors[:comment]).to include("is too long (maximum is 100 characters)")
    end

    it "is valid with a nickname that has less than 100 characters " do
      product = build(:product, comment: "a" * 100)
      expect(product).to be_valid
    end

    it "is invalid with a name that has more than 8 characters " do
      product = build(:product, price: "22222222")
      product.valid?
      expect(product.errors[:price]).to include("is too long (maximum is 7 characters)")
    end

    it "is valid with a nickname that has less than 7 characters " do
      product = build(:product, price: "2222222")
      expect(product).to be_valid
    end
  end
end