require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "valid with all fields" do
      category = Category.new()
      category.save()
      product = Product.new(name: "test", price: 100, quantity: 3, category: category)
      product.save()
      expect(product.errors.full_messages).to match_array([])
    end

    it "invalid missing name" do
      category = Category.new()
      category.save()
      product = Product.new(price: 100, quantity: 3, category: category)
      product.save()
      expect(product.errors.full_messages).to_not be_empty
    end

    it "invalid missing price" do
      category = Category.new()
      category.save()
      product = Product.new(name: "test", quantity: 3, category: category)
      product.save()
      expect(product.errors.full_messages).to_not be_empty
    end

    it "invalid missing quantity" do
      category = Category.new()
      category.save()
      product = Product.new(name: "test", price: 100, category: category)
      product.save()
      expect(product.errors.full_messages).to_not be_empty
    end

    it "invalid missing category" do
      product = Product.new(name: "test", price: 100, quantity: 3)
      product.save()
      expect(product.errors.full_messages).to_not be_empty
    end
  end
end
