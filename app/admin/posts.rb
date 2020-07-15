ActiveAdmin.register Post do
  menu priority: 6
  # belongs_to :site

  member_action :comments do
    @comments = resource.comments
    # This will render app/views/admin/posts/comments.html.erb
  end

  show do
    attributes_table do
      row :canonical_url
      row :thumbnail_url
      row :identifier
      row :site
      row :created_at
      row :updated_at
      row :rating_avg
      row :comments_count
      row :displayed_comments_count
      row :comments
    end
    active_admin_comments
  end
end
