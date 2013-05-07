FactoryGirl.define do
  factory :comment do
    user { FactoryGirl.create :user }
    event { FactoryGirl.create :event }
    content "MyText"
  end
end
