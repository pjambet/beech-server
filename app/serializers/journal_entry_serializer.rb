class JournalEntrySerializer < ActiveModel::Serializer
  attributes :id, :entry_type, :loggable_type, :loggable_id

  has_one :loggable, polymorphic: true
end
