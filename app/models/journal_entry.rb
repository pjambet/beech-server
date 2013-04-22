class JournalEntry < ActiveRecord::Base
  belongs_to :loggable, polymorphic: true

  validates :loggable, presence: true
  validates :entry_type, presence: true

  attr_accessible :entry_type, :loggable

  default_scope -> { order('journal_entries.created_at ASC') }
  scope :after, ->(last_id) { where('journal_entries.id > ?', last_id) }
end
