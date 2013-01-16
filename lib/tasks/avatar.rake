desc "Assign random avatars"
namespace :avatar do
  # TODO : add an option to force reassignment to ALL users
  task assign: :environment do
    User.all.each do |user|
      if user.avatar.blank?
        image = File.open("public/default-avatar-#{(rand 4) + 1}.png")
        user.avatar = image
        user.save!
      end
    end
  end
end

