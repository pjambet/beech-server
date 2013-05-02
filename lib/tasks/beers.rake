namespace :beers do
  task assign_color: :environment do
    Beer.all.each do |beer|
      beer.assign_color
    end
  end

  task generate_journal: :environment do
    Beer.accepted.each do |beer|
      JournalEntry.create(loggable: beer, entry_type: 'new')
    end
  end
end

