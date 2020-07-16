ActiveAdmin.register Post do
  menu priority: 6
  includes site: :organization

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

  index do
    selectable_column
    column :site
    column '(#ID) Identifier' do |post|
      link_to "(##{post.id}) #{post.identifier}", admin_post_path(post)
    end
    column :visit_count
    column 'Comments Count (Displayed / Hidden / Total)' do |post|
      displayed = post.displayed_comments_count
      all = post.comments_count
      hidden = all - displayed

      "#{displayed} / #{hidden} / #{all}"
    end
    column :rating_avg
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :site
      row :identifier
      row :canonical_url
      row :thumbnail_url
      row :rating_avg
      row :comments_count
      row :displayed_comments_count
      row :visit_count
      row :created_at
      row :updated_at
      row :comments
    end

    render 'locations', post: post
    render 'comments', post: post

    active_admin_comments
  end
end
