Lrspec::Application.routes.draw do

  resources :contacts do
    member do
      patch 'hide'
    end
  end

  root to: 'contacts#index'

end
