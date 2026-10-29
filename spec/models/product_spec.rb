require "rails_helper"

RSpec.describe Product, type: :model do
  describe "validations" do
    it "requires a title" do
      product = Product.new(title: nil)
      product.valid?

      expect(product.errors[:title]).to include("can't be blank")
    end

    it "requires a description" do
      product = Product.new(description: nil)
      product.valid?

      expect(product.errors[:description]).to include("can't be blank")
    end

    it "requires a price greater than or equal to 0.01" do
      product = Product.new(price: 0)

      expect(product).not_to be_valid
      expect(product.errors[:price]).not_to be_empty
    end

    it "accepts a price of 0.01" do
      product = Product.new(price: 0.01)

      product.valid?

      expect(product.errors[:price]).to be_empty
    end
  end
end
