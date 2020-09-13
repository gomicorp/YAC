scope module: :service do
  namespace :search do
    resources :admins, only: %i[index]
  end

  resources :organizations do
    resources :sites
    resources :admin_permissions
  end

  resources :comments
end
