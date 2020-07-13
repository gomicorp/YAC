# == Schema Information
#
# Table name: organization_admin_permissions
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  admin_id        :bigint           not null
#  organization_id :bigint           not null
#
# Indexes
#
#  index_organization_admin_permissions_on_admin_id         (admin_id)
#  index_organization_admin_permissions_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (admin_id => users.id)
#  fk_rails_...  (organization_id => organizations.id)
#
class OrganizationAdminPermission < ApplicationRecord
  belongs_to :organization
  belongs_to :admin, class_name: 'User'
end
