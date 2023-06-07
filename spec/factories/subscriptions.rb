FactoryBot.define do
  factory :subscription do
    title { Faker::Book.title }
    price { [12.00, 20.00, 40.00].sample }
    status { [0,1].sample }
    frequency { [0,1].sample }
  end
end