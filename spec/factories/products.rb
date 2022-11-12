FactoryBot.define do
  factory :product do
    user
    name { "test" }
    price { 1_000 }
  end
end
