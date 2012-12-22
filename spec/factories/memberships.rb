
FactoryGirl.define do
  factory :membership do
    role { create :role }
    user { create :user }
  end
end

