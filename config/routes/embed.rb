concern :paginatable do
  get '(page/:page)', action: :index, on: :collection, as: ''
end

namespace :embed do
  resources :comments, only: :index
  resources :posts, only: [] do
    resources :comments, concerns: [:paginatable]
  end
end
