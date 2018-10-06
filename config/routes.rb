Rails.application.routes.draw do

  get 'stories/index'
  devise_for :users
  #resources :users do
    #resources :read_and_deleteds
  #end
  resource :home
  resources :stories
  resource :stories do
    member do
      post :mark_post_as_read
      post :delete_story_for_user
    end
  end
  root 'stories#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
