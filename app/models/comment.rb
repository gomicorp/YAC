# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  remote_ip  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#
class Comment < ApplicationRecord
  has_rich_text :content

  belongs_to :post, counter_cache: true

  validates :remote_ip, presence: true
end
