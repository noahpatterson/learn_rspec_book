Lrspec::Application.routes.draw do

  resources :contacts
  get 'hide_contact' => 'contacts#hide_contact'

  root to: 'contacts#index'

end
