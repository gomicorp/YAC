# == Schema Information
#
# Table name: sites
#
#  id              :bigint           not null, primary key
#  name            :string(255)
#  domain          :string(255)
#  organization_id :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Site < ApplicationRecord
  belongs_to :organization
  has_many :posts, class_name: 'Post'

  validates :name, presence: true
  validates :domain, presence: true
end
