FactoryBot.define do
  factory :order do
    sub_total { 1.5 }
    total { 1.5 }
    shipping_status { "MyString" }
  end
end
