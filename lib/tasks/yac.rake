require_relative 'helper'

namespace :yac do
  desc 'Sample site address is updated'
  task sampled: :environment do
    rake 'db:seed' if Rails.env.development?
  end
end
