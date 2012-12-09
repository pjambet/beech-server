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

