FactoryGirl.define do
  factory :check do
    user { create :user }
    beer { create :beer }
  end

  factory :check_attributes, class: Check do
    user_id { create(:user).id }
    beer_id { create(:beer).id }
  end
end
