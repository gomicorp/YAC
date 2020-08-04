ActiveAdmin.register Comment do
  menu priority: 7
  includes :post, :author

  controller do
    def scoped_collection
      super.service_admin_scope
    end
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :remote_ip, :post_id, :author_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:remote_ip, :post_id, :author_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    column :id
    column :post
    column 'Parent Comment', :comment
    column :content do |comment|
      comment.content.body
    end
    column :rating
    column :author
    column :remote_ip
    column :created_at
    column :hide_at
    actions
  end
end
