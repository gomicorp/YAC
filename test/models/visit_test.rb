# == Schema Information
#
# Table name: visits
#
#  id               :bigint           not null, primary key
#  uri              :text(65535)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  post_location_id :bigint           not null
#
# Indexes
#
#  index_visits_on_post_location_id  (post_location_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_location_id => post_locations.id)
#
require 'test_helper'

class VisitTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
