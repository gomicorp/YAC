# == Schema Information
#
# Table name: posts
#
#  id                       :bigint           not null, primary key
#  canonical_url            :string(255)
#  comments_count           :integer          default(0)
#  displayed_comments_count :integer          default(0), not null
#  identifier               :string(255)      default(""), not null
#  locations_count          :integer          default(0), not null
#  rating_avg               :float(24)        default(0.0), not null
#  thumbnail_url            :string(255)
#  visit_count              :integer          default(0), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  site_id                  :bigint           not null
#
# Indexes
#
#  index_posts_on_canonical_url           (canonical_url)
#  index_posts_on_identifier_and_site_id  (identifier,site_id) UNIQUE
#  index_posts_on_site_id                 (site_id)
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
