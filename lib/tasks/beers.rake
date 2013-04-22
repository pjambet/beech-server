namespace :beers do
  task assign: :environment do
    Beer.all.select{|beer| beer.color_pattern.blank? }.each do |beer|
      beer.assign_color_pattern
      p "Added color pattern to : #{beer.name}"
    end
  end

  task generate_journal: :environment do
    Beer.all.each do |beer|
      JournalEntry.create(loggable: beer, entry_type: 'new')
    end
  end
end

