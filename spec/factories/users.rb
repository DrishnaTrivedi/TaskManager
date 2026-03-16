FactoryBot.define do 
  factory :user do
    name {"Matt"}
    sequence(:email) { |n| "matt#{n}@gmail.com" }
    password { "123456" }
  end
end 