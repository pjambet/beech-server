FactoryGirl.define do
  factory :like do
    user { FactoryGirl.create(:user) }
    event { FactoryGirl.create(:event) }
  end
end
