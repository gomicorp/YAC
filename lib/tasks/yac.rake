require_relative 'helper'

namespace :yac do
  desc 'Sample site address is updated'
  task sampled: :environment do
    rake 'db:seed' if Rails.env.development?
  end

  desc 'Download user profile image url to storage'
  task download_user_profile: :environment do
    User.make_profile_image
  end
end
