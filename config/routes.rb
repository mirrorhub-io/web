Rails.application.routes.draw do
  root 'welcome#index'

  get '/login' => 'contact#login'
  get '/register' => 'contact#register'
  get '/logout' => 'contact#logout'

  post '/login' => 'contact#signin'
  post '/register' => 'contact#signup'
end
