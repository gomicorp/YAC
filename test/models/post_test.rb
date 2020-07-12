# == Schema Information
#
# Table name: posts
#
#  id             :bigint           not null, primary key
#  canonical_url  :string(255)
#  comments_count :integer          default(0)
#  thumbnail_url  :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  site_id        :bigint           not null
#
# Indexes
#
#  index_posts_on_canonical_url  (canonical_url) UNIQUE
#  index_posts_on_site_id        (site_id)
#
# Foreign Keys
#
#  fk_rails_...  (site_id => sites.id)
#
require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
