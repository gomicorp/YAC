# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  remote_ip  :string(255)
#  post_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Comment < ApplicationRecord
  belongs_to :post, counter_cache: true

  validates :remote_ip, presence: true
end
