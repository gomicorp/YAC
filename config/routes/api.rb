# == Route Map
#
#             Prefix Verb       URI Pattern                                        Controller#Action
#          api_posts GET        /api/:api_key/sites/:domain/posts                  api/posts#index {:domain=>/[^\/]*/}
#           api_post GET        /api/:api_key/sites/:domain/posts/:id              api/posts#show {:domain=>/[^\/]*/}
#       api_comments GET        /api/:api_key/sites/:domain/comments               api/comments#index {:domain=>/[^\/]*/}
#        api_comment GET        /api/:api_key/sites/:domain/comments/:id           api/comments#show {:domain=>/[^\/]*/}
#        api_authors GET        /api/:api_key/sites/:domain/authors                api/authors#index {:domain=>/[^\/]*/}
#         api_author GET        /api/:api_key/sites/:domain/authors/:id            api/authors#show {:domain=>/[^\/]*/}
#          api_sites GET        /api/:api_key/sites                                api/sites#index {:format=>:json}
#           api_site GET        /api/:api_key/sites/:domain                        api/sites#show {:domain=>/[^\/]*/}
#
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
