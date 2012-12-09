FactoryGirl.define do
  factory :following do
    followee { create :user }
    follower { create :user }
  end
end
