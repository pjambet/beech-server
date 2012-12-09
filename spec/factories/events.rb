
FactoryGirl.define do
  factory :event do
    eventable { create :check }
  end
end
