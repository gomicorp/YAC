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

  # show do
  #   attributes_table do
  #     row :comments_count
  #     row :displayed_comments_count
  #   end
  # end
  # belongs_to :site
end
