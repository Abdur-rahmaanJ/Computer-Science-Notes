Rails.application.routes.draw do
  get 'other/name'

  get 'other/index'

  get 'other/show'

  get 'other/change'

  get 'other/quote'

  get 'main/welcome'

  get 'main/goodbye'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase


end
