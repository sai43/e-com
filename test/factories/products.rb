FactoryBot.define do
  factory :product do
    name { FFaker::Product.product_name }
    price { rand() * 100 }
    description { "MyText" }
    quantity { 1 }
  end
end
