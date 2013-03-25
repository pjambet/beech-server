class Setting < ActiveRecord::Base
  serialize :properties, ActiveRecord::Coders::Hstore
end
