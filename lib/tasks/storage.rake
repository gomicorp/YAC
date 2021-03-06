namespace :storage do
  desc 'Migrate ActiveStorage files from local to Amazon S3'
  task migrate: :environment do
    ActiveStorage.migrate(:local, :amazon)
  end
end
