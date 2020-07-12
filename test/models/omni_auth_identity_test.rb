# == Schema Information
#
# Table name: omni_auth_identities
#
#  id         :bigint           not null, primary key
#  provider   :string(255)
#  uid        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_omni_auth_identities_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class OmniAuthIdentityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
