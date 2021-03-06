# == Schema Information
#
# Table name: post_locations
#
#  id          :bigint           not null, primary key
#  address     :string(255)      default(""), not null
#  visit_count :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  post_id     :bigint           not null
#
# Indexes
#
#  index_post_locations_on_address              (address)
#  index_post_locations_on_post_id              (post_id)
#  index_post_locations_on_post_id_and_address  (post_id,address) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#
require 'test_helper'

class PostLocationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
