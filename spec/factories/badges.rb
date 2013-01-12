FactoryGirl.define do
  factory :badge do
    name { Faker::Name.name }
    condition { Faker::Lorem.words(4).join('') }
    badge_type { 'quantity' }
  end
end

