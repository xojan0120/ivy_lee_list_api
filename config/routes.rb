Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      get    '/ill/items',                           to: 'items#index'
      post   '/ill/items',                           to: 'items#create'
      put    '/ill/items/:item_id/archive',          to: 'items#archive'
      patch  '/ill/items/:item_id/update_order',     to: 'items#update_order'
      get    '/ill/archived_items',                  to: 'archived_items#index'
      put    '/ill/archived_items/:item_id/restore', to: 'archived_items#restore'
      delete '/ill/archived_items/:item_id',         to: 'archived_items#destroy'
      delete '/ill/archived_items',                  to: 'archived_items#destroy_all'
    end
  end
end
