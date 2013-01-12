desc "Create badges"
namespace :badges do
  task create: :environment do
    Badge.destroy_all

    Badge.create badge_type: 'quantity', condition: 'any', quantity: 3, name: "3 bieres"
    Beer.all.each do |b|
      Badge.create badge_type: 'quantity', condition: "beer:#{b.name}", quantity: 5, name: "5 #{b.name}"
    end
  end
end

