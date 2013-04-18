namespace :beers do
  task assign: :environment do
    Beer.all.select{|beer| beer.color_pattern.blank? }.each do |beer|
      beer.assign_color_pattern
      p "Added color pattern to : #{beer.name}"
    end
  end
end

