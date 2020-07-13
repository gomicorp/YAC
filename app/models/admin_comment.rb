# == Schema Information
#
# Table name: active_admin_comments
#
#  id            :bigint           not null, primary key
#  author_type   :string(255)
#  body          :text(65535)
#  namespace     :string(255)
#  resource_type :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  author_id     :bigint
#  resource_id   :bigint
#
# Indexes
#
#  index_active_admin_comments_on_author_type_and_author_id      (author_type,author_id)
#  index_active_admin_comments_on_namespace                      (namespace)
#  index_active_admin_comments_on_resource_type_and_resource_id  (resource_type,resource_id)
#
class AdminComment < ActiveAdmin::Comment
end
