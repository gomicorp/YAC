# == Schema Information
#
# Table name: post_locations
#
#  id          :bigint           not null, primary key
#  address     :string(255)      default(""), not null
#  visit_count :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  post_id     :bigint           not null
#
# Indexes
#
#  index_post_locations_on_address              (address)
#  index_post_locations_on_post_id              (post_id)
#  index_post_locations_on_post_id_and_address  (post_id,address) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#
class PostLocation < ApplicationRecord
  belongs_to :post, counter_cache: :locations_count
  has_many :visits, class_name: 'PostVisit'

  validates :address, presence: true, uniqueness: { scope: :post_id, case_sensitive: true }

  after_save :after_save_callback
  after_destroy :after_destroy_callback

  def self.visit!(uri)
    uri = URI(uri)
    transaction do
      find_or_create_by!(address: uri.url).tap do |location|
        location.visits.create!(uri: uri)
        location.send(:update_counter_cache)
      end
    end
  end

  private

  # === Callbacks
  #
  def after_save_callback
    locations = post.reload.locations
    update_counter_cache locations
  end

  def after_destroy_callback
    locations = post.reload.locations
    update_counter_cache locations
  end

  def update_counter_cache(locations = nil)
    locations ||= reload.post.locations
    post.update(visit_count: locations.sum(:visit_count))
  end
end
