Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'welcome#index'
  get '/cats' => 'cats#index'
  get '/cats/:name' => 'cats#show', constraints: { name: /kuzya|iriska|anya/ }
  get '/events' => 'events#index'
  #get '/theatres/national' => 'national#index'
  #get '/theatres/southbank' => 'southbank#index'

  get '/theatres' => 'theatres#index'
  get '/theatres/:theatre' => 'theatres#index', constraints: { name: /national|southbank|roh/ }
  #params[:theatre]
end
