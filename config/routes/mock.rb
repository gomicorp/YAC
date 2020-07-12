namespace :mock do
  resources :posts, only: %i[index show]
end
