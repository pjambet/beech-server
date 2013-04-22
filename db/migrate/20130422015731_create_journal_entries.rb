class CreateJournalEntries < ActiveRecord::Migration
  def change
    create_table :journal_entries do |t|
      t.string :loggable_type
      t.belongs_to :loggable
      t.string :entry_type
      t.timestamps
    end
    add_index :journal_entries, :loggable_id
  end
end
