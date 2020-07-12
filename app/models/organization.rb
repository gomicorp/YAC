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
class Organization < ApplicationRecord
  extend FriendlyId
  has_many :sites, class_name: 'Site', dependent: :destroy
  has_many :posts, through: :sites
  has_many :comments, through: :posts

  friendly_id :api_key
  validates :name, presence: true
  validates :api_key, presence: true, uniqueness: true

  before_validation :set_api_key, on: :create


  private

  def set_api_key
    self.api_key = SecureRandom.uuid
  end
end
