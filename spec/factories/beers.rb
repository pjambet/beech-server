FactoryGirl.define do
  factory :beer do
    name { Faker::Name.name }
  end
end

