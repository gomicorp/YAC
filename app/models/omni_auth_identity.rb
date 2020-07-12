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
class OmniAuthIdentity < ApplicationRecord
  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_for_oauth(auth)
    find_or_initialize_by(uid: auth.uid, provider: auth.provider)
  end
end
