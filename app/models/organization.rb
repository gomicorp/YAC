# == Schema Information
#
# Table name: organizations
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Organization < ApplicationRecord
  has_many :sites, class_name: 'Site'
  has_many :posts, through: :sites
  has_many :comments, through: :posts

  validates :name, presence: true
end
