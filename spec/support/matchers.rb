RSpec::Matchers.define :act_as_eventable do
  match do |actual|
    actual.should have_one(:event)
  end
end

RSpec::Matchers.define :act_as_pageable do
  match do |actual|
    actual.class.should respond_to(:per_page)
  end
end


RSpec::Matchers.define :act_as_searchable do
  match do |actual|
    actual.class.should respond_to(:search_for)
  end
end

RSpec::Matchers.define :act_as_likable do
  match do |actual|
    actual.should have_many(:likes)
    actual.should have_many(:likers).through(:likes)
  end
end

RSpec::Matchers.define :act_as_commentable do
  match do |actual|
    actual.should have_many(:comments)
    actual.should have_many(:commenters).through(:comments)
  end
end
