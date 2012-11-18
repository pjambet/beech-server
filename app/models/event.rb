class Event < ActiveRecord::Base
  belongs_to :eventable, polymorphic: true

  default_scope -> { includes :eventable }
end
