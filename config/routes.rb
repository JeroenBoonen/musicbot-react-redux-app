Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/api/spotify/token', to: 'spotify#token'
  get '/api/spotify/search', to: 'spotify#search'
  get '/api/profiles', to: 'profile#show_profile'
  post '/api/spotify/save', to: 'spotify#save_search'
  post '/api/profiles', to: 'profile#create'
  post '/api/profiles/:profile_id/recommendations', to: 'profile#recommend'
  post '/api/profiles/:profile_id/likes', to: 'profile#like'
  patch '/api/profiles/signin', to: 'profile#sign_in'
  patch '/api/profiles/:profile_id/likes', to: 'profile#update_like'
end
