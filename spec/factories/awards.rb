FactoryGirl.define do
  factory :award do
    user { create :user }
    badge { create :badge }
  end

  factory :award_attributes, class: Award do
    user_id { create(:user).id }
    badge_id { create(:badge).id }
  end
end

