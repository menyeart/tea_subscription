FactoryBot.define do
  factory :tea do
    title { Faker::Tea }
    description { Faker::Books::Dune.quote }
    brew_time { [4.00, 4.30, 5.00].sample }
    temp { [150, 160, 180].sample }
  end
end