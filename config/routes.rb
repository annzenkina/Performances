Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'theatres#index'

  #get '/theatres/national' => 'national#index'
  #get '/theatres/southbank' => 'southbank#index'

  get '/theatres' => 'theatres#index'
  get '/theatres/:theatre' => 'theatres#index', constraints: { name: /national|southbank|roh/ }
end
