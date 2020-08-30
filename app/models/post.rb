# == Schema Information
#
# Table name: posts
#
#  id                       :bigint           not null, primary key
#  canonical_url            :string(255)
#  comments_count           :integer          default(0)
#  displayed_comments_count :integer          default(0), not null
#  identifier               :string(255)      default(""), not null
#  locations_count          :integer          default(0), not null
#  rating_avg               :float(24)        default(0.0), not null
#  thumbnail_url            :string(255)
#  visit_count              :integer          default(0), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  site_id                  :bigint           not null
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
  extend FriendlyId
  belongs_to :site
  has_many :comments, class_name: 'Comment', dependent: :destroy
  has_many :locations, class_name: 'PostLocation', dependent: :destroy
  has_many :visits, class_name: 'PostVisit', through: :locations

  friendly_id :identifier

  validates :identifier, presence: true, uniqueness: { scope: :site, case_sensitive: true }

  def update_self_counter_cache
    self.displayed_comments_count = comments.displayed.count
    self.visit_count = locations.sum(:visit_count)
    save
  end
end
