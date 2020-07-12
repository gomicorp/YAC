# == Schema Information
#
# Table name: organizations
#
#  id         :bigint           not null, primary key
#  api_key    :string(255)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_organizations_on_api_key  (api_key) UNIQUE
#
require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
