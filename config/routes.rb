Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'welcome#index'

  get '/merchants/:id/dashboard', to: 'merchants/dashboard#show', as: 'merchant_dashboard'

  resources :merchants, only: [] do
    scope module: 'merchants' do
      resources :items, except: :destroy
      resources :invoices, only: [:index, :show]
      resources :bulk_discounts, only: [:index, :show, :new, :create]
    end
  end

  get '/admin', to: 'admin/dashboard#index'

  namespace :admin do
    resources :merchants, except: :destroy
    resources :invoices, only: [:index, :show, :update]
  end

  resources :invoices, only: [] do
    scope module: 'invoices' do
      resources :invoice_items, only: :update
    end
  end
end
