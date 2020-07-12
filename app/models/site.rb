# == Schema Information
#
# Table name: sites
#
#  id              :bigint           not null, primary key
#  domain          :string(255)
#  name            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#
# Indexes
#
#  index_sites_on_domain           (domain) UNIQUE
#  index_sites_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#
class Site < ApplicationRecord
  extend FriendlyId
  belongs_to :organization
  has_many :posts, class_name: 'Post', dependent: :destroy
  has_many :comments, through: :posts

  has_one_attached :footer_logo
  friendly_id :domain
  validates :name, presence: true
  validates :domain, presence: true, uniqueness: true
end
