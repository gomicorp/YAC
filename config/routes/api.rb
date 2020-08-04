namespace :api, path: 'api/:api_key' do
  defaults format: :json do
    resources :authors, only: %i[index show]
  end
end
