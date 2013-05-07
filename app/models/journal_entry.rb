# == Schema Information
#
# Table name: journal_entries
#
#  id            :integer          not null, primary key
#  loggable_type :string(255)
#  loggable_id   :integer
#  entry_type    :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class JournalEntry < ActiveRecord::Base
  belongs_to :loggable, polymorphic: true

  validates :loggable, presence: true
  validates :entry_type, presence: true

  attr_accessible :entry_type, :loggable

  default_scope -> { order('journal_entries.created_at ASC') }
  scope :after, ->(last_id) { where('journal_entries.id > ?', last_id) }
end
