FactoryBot.define do
  factory :item do
    sequence(:title)        {|n| "title#{n}"}
    sequence(:order_number) {|n| n}
  end

  trait :separator do
    id 1
    title "-----"
    order_number 0
  end
end
