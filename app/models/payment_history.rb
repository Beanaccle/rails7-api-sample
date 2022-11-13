class PaymentHistory < ApplicationRecord
  belongs_to :product, optional: true
  belongs_to :seller, class_name: "User", foreign_key: :seller_id
  belongs_to :buyer, class_name: "User", foreign_key: :buyer_id

  validates :product_name, presence: true
  validates :product_price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
