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

    collection do
      get 'sdk'
    end
  end

  resources :posts, only: [] do
    resources :comments, concerns: [:paginatable]
  end

  scope :active_storage do
    resource :direct_uploads, controller: '/embed/active_storage/direct_uploads', only: :create
  end
end
