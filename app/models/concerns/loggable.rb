module Loggable
  extend ActiveSupport::Concern

  included do
    after_create do
      create_log('new')
    end

    after_update do
      create_log('edit')
    end

    after_destroy do
      create_log('deletion')
    end

    def create_log(log_type)
      if should_be_logged?
        JournalEntry.create(
          loggable: self,
          entry_type: log_type
        )
      end
    end

    def should_be_logged?
      true
    end
  end
end
