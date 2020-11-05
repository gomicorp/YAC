# == Schema Information
#
# Table name: settings
#
#  id                         :bigint           not null, primary key
#  comment_display_created_at :boolean          default(TRUE), not null
#  comment_repeatable         :boolean          default(FALSE), not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  site_id                    :bigint           not null
#
# Indexes
#
#  index_settings_on_site_id  (site_id)
#
# Foreign Keys
#
#  fk_rails_...  (site_id => sites.id)
#
require 'test_helper'

class SettingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
