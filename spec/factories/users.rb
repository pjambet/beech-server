FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "password33"
    password_confirmation "password33"

    trait :with_checks do
      after(:create) do |user|
        user.checks = [
          create(:check, beer: create(:beer, name: 'Kronembourg')),
          create(:check, beer: create(:beer, name: 'Stella Artois')),
          create(:check, beer: create(:beer, name: 'Guiness')),
        ]
      end
    end
  end

end
