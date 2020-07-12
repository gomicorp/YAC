# == Schema Information
#
# Table name: posts
#
#  id             :bigint           not null, primary key
#  canonical_url  :string(255)
#  comments_count :integer          default(0)
#  identifier     :string(255)      default(""), not null
#  thumbnail_url  :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  site_id        :bigint           not null
#
# Indexes
#
#  index_posts_on_canonical_url           (canonical_url)
#  index_posts_on_identifier_and_site_id  (identifier,site_id) UNIQUE
#  index_posts_on_site_id                 (site_id)
#
# Foreign Keys
#
#  fk_rails_...  (site_id => sites.id)
#
class Post < ApplicationRecord
  belongs_to :site
  has_many :comments, class_name: 'Comment', dependent: :destroy

  validates :identifier, presence: true, uniqueness: { scope: :site }
end
