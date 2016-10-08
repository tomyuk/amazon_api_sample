#
#
#
Rails.application.routes.draw do

  # For devise
  devise_for(:users, 
             # only: :session, 
             sign_out_via: [
               :get, 
               # :post, 
               :delete], 
             controllers: {
               sessions: 'users/sessions',
               unlocks: 'users/unlocks',
             },
             path: '')

  #-------------------------------------------------------------------

  root 'home#index'

  get 'dash_board', to: 'dash_board#index'
  
  resources :users
  
  resources :invoices do
  end

  get :order_history, to: "system_logs#order_history"

  resources :damage_tables
  resources :system_logs, only: [:index, :show]
  resources :settings, only: [:edit, :update]

end
