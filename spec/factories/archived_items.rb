FactoryBot.define do
  factory :archived_item do
    sequence(:title)        {|n| "title#{n}"}
    sequence(:order_number) {|n| n}
  end
end
