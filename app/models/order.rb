class Order < ApplicationRecord
  
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  def subtotal
    line_items.sum do |item|
      item.quantity * item.product.price
    end
  end

end
