Rails.application.routes.draw do
  root 'landing#main'
  get 'sample/index'

  draw :embed
end
