ActiveAdmin.register Post do
  menu priority: 6

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :canonical_url, :thumbnail_url, :site_id, :comments_count, :identifier
  #
  # or
  #
  # permit_params do
  #   permitted = [:canonical_url, :thumbnail_url, :site_id, :comments_count, :identifier]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

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
