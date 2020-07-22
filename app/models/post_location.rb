# == Schema Information
#
# Table name: post_locations
#
#  id          :bigint           not null, primary key
#  address     :string(255)      default(""), not null
#  uri         :text(65535)
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
  attribute :uri, :uri
  belongs_to :post, counter_cache: :locations_count

  validates :uri, presence: true, uniqueness: { scope: :post_id, case_sensitive: true }

  after_save :after_save_callback
  after_destroy :after_destroy_callback

  def self.visit!(uri)
    post_location = find_or_initialize_by(uri: uri)
    post_location.visit
  end

  def visit
    self.visit_count += 1
    save
  end

  # @override setter
  def uri=(value)
    super(value)
    self.address = uri.url
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
