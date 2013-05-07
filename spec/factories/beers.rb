FactoryGirl.define do
  factory :beer do
    name { Faker::Name.name }
    accepted true

    trait :blond do
      beer_color { BeerColor.blond }
    end
    trait :dark do
      beer_color { BeerColor.dark }
    end
    trait :white do
      beer_color { BeerColor.white }
    end
    trait :amber do
      beer_color { BeerColor.amber }
    end
    trait :suggested do
      accepted nil
    end
    trait :rejected do
      accepted false
    end
  end

end

