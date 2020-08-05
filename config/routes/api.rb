namespace :api, path: 'api/:api_key' do
  defaults format: :json do
    resources :sites, only: %i[index show], param: :domain, constraints: { domain: /[^\/]*/ } do
      member do
        resources :posts, only: %i[index show]
        resources :comments, only: %i[index show]
        resources :authors, only: %i[index show]
      end
    end
  end
end
