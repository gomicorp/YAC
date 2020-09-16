scope module: :service do
  namespace :search do
    resources :admins, only: %i[index]
  end

  resources :organizations do
    resources :sites
    resources :admin_permissions
  end

  scope 'sites/:site_id', as: :site do
    resources :comments do
      collection { post '', to: 'comments#index', as: :search }
    end
  end
end
