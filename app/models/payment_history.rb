# frozen_string_literal: true

class PaymentHistory < ApplicationRecord
  belongs_to :product, optional: true
  belongs_to :seller, class_name: 'User', inverse_of: :seller_payment_histories
  belongs_to :buyer, class_name: 'User', inverse_of: :buyer_payment_histories

  validates :product_name, presence: true
  validates :product_price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
