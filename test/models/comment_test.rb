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
require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
