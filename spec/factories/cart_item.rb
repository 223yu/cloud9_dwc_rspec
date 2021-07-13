FactoryBot.define do
  factory :cart_item do
    customer
    item
    quantity { 2 }
  end
end