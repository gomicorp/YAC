concern :paginatable do
  get '(page/:page)', action: :index, on: :collection, as: ''
end

namespace :embed do
  resources :comments, only: :index do
    member do
      scope controller: 'comments/actions' do
        patch 'hide', 'display'
      end
    end
  end

  resources :posts, only: [] do
    resources :comments, concerns: [:paginatable]
  end
end
