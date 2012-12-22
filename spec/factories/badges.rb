FactoryGirl.define do
  factory :badge do
    name { Faker::Name.name }
    condition { Faker::Lorem.words(4).join('') }
  end
end

