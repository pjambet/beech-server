FactoryGirl.define do
  factory :beer_color do
    slug { Faker::Name.name }
  end
end

