# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  remote_ip  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :bigint           not null
#  post_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_author_id  (author_id)
#  index_comments_on_post_id    (post_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#  fk_rails_...  (post_id => posts.id)
#
class Comment < ApplicationRecord
  has_rich_text :content

  belongs_to :post, counter_cache: true
  belongs_to :author, class_name: 'User'

  validates :remote_ip, presence: true
  validates :author_id, presence: true

  scope :with_author, -> { includes(:author) }
end
