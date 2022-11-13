FactoryBot.define do
  factory :payment_history do
    product
    seller { product.user }
    buyer { build(:user, email: "buyer@example.com") }
    product_name { "test" }
    product_price { 1_000 }
  end
end
