require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
      @category = Category.new(name: 'Bushes')
    end

    it 'Should have a name' do
      product = Product.new(
        name: nil,
        price_cents: 50,
        quantity: 20,
        category: @category 
      )

      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'Should have a price' do
      product = Product.new(
        name: 'Red Bush',
        price_cents: nil,
        quantity: 20,
        category: @category 
      )

      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it 'Should have a quantity' do
      product = Product.new(
        name: 'Red Bush',
        price_cents: 50,
        quantity: nil,
        category: @category 
      )

      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'Should have a category' do
      product = Product.new(
        name: 'Red Bush',
        price_cents: 50,
        quantity: 20,
        category: nil
      )

      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Category can't be blank")
    end

    it 'is created when all the info is entered' do
      product = Product.new(
        name: 'Red Bush',
        price_cents: 50,
        quantity: 20,
        category: @category
      )

      expect(product).to be_valid
    end

  end
end
