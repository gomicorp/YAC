# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  hide_at    :datetime
#  remote_ip  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :bigint           not null
#  comment_id :bigint
#  post_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_author_id   (author_id)
#  index_comments_on_comment_id  (comment_id)
#  index_comments_on_post_id     (post_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#  fk_rails_...  (comment_id => comments.id)
#  fk_rails_...  (post_id => posts.id)
#
class Comment < ApplicationRecord
  has_rich_text :content

  belongs_to :post, counter_cache: true
  belongs_to :author, class_name: 'User'

  has_many :comments, class_name: 'Comment'
  belongs_to :comment, class_name: 'Comment', optional: true

  validates :remote_ip, presence: true
  validates :author_id, presence: true

  after_save :after_save_callback
  after_destroy :after_destroy_callback

  scope :with_author, -> { includes(:author) }
  scope :displayed, -> { where(hide_at: nil) }
  scope :hide, -> { where.not(hide_at: nil) }

  scope :service_admin_scope, -> { with_author.with_rich_text_content_and_embeds.order(id: :desc) }
  scope :service_scope, -> { with_author.displayed.with_rich_text_content_and_embeds.order(id: :desc) }


  def displayed?
    hide_at.nil?
  end

  def hide?
    !displayed?
  end

  # === Callbacks
  #
  def after_save_callback
    update_counter_cache
  end

  def after_destroy_callback
    update_counter_cache
  end

  def update_counter_cache
    post.update(displayed_comments_count: reload.post.comments.displayed.count)
  end
end
