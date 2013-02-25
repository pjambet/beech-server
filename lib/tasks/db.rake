namespace :db do
  task migrate: :environment do
    if Rails.env.development?
      Rake::Task['db:test:prepare'].invoke
      `annotate --exclude tests,fixtures,factories`
    end
  end
end
