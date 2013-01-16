FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    nickname { Faker::Name.name }
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

    trait :with_awards do
      after(:create) do |user|
        user.awards = [
          create(:award, badge: create(:badge, name: '5 Kronembourg')),
          create(:award, badge: create(:badge, name: '5 Stella Artois')),
        ]
      end
    end

    trait :admin do
      after(:create) do |user|
        user.roles << Role.admin_role
      end
    end
  end

end

