Itunes::Application.routes.draw do
  
  get "goodbye/wave"

  get "buy/songo"

  get "add/song"

  get "show/list_song"

  get "show/album"

  get "show/actor"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)
  
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'show#list_song'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
