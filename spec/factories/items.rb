FactoryBot.define do
  factory :item do
    id              {1}
    name            {"test-item"}
    description     {"テストの商品です"}
    condition       {0}
    shipping_fee    {0}
    shipping_date   {0}
    price           {1000}
    status          {0}
    prefecture_id   {1}
    shipping_method {0}
    association :category
    association :seller, factory: :user
  end
end