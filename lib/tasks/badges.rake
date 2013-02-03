desc "Create badges"
namespace :badges do
  task create: :environment do
    Badge.destroy_all

    Badge.create badge_type: 'quantity', condition: 'any', quantity: 3, name: "3 bieres"
    Beer.all.each do |b|
      Badge.create badge_type: 'quantity', condition: "beer:#{b.name}", quantity: 5, name: "5 #{b.name}"
    end
  end

  task assign: :environment do
    Badge.all.select{|badge| badge.photo.blank? }.each do |badge|
      image = File.open("public/default-badge-#{(rand 3) + 1}.png")
      badge.photo = image
      badge.save!
      p "Changed avatar for #{badge.name}"
    end
  end
end

