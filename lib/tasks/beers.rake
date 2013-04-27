namespace :beers do
  task generate_journal: :environment do
    Beer.accepted.each do |beer|
      JournalEntry.create(loggable: beer, entry_type: 'new')
    end
  end
end

