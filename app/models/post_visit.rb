# == Schema Information
#
# Table name: post_visits
#
#  id               :bigint           not null, primary key
#  uri              :text(65535)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  post_location_id :bigint           not null
#
# Indexes
#
#  index_post_visits_on_post_location_id  (post_location_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_location_id => post_locations.id)
#
class PostVisit < ApplicationRecord
  attribute :uri, :uri
  belongs_to :post_location, counter_cache: :visit_count

  validates :uri, presence: true
end
