FactoryGirl.define do
  factory :beer do
    name { Faker::Name.name }

    trait :blond do
      beer_color { BeerColor.blond }
    end
  end

end

