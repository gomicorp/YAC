# == Schema Information
#
# Table name: posts
#
#  id            :bigint           not null, primary key
#  canonical_url :string(255)
#  thumbnail_url :string(255)
#  site_id       :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  comment_count :integer          default(0)
#
require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
