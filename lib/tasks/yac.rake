namespace :yac do
  desc 'Sample site address is updated'
  task sampled: :environment do
    $stdout.puts Organization.first.sites.create!(
      name: 'YAC Sample',
      domain: ENV['PROXY_URL']
    )
  end
end
