FactoryBot.define do
  factory :user do
    email { "test@example.com" }
    password { "password" }
    points { 0 }
  end
end
