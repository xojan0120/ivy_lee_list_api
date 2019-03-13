Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      #resources :ill
      get '/ill/fetchAllItem', to: 'ill#fetchAllItem'
      get '/ill/fetchAllArchivedItem', to: 'ill#fetchAllArchivedItem'
      post '/ill/addItem', to: 'ill#addItem'
      put '/ill/moveItem/:itemId', to: 'ill#moveItem'
      post '/ill/archiveItem', to: 'ill#archiveItem'
      post '/ill/restoreItem', to: 'ill#restoreItem'
      delete '/ill/deleteItem/:itemId', to: 'ill#deleteItem'
      delete '/ill/deleteAllArchivedItem', to: 'ill#deleteAllArchivedItem'

      #get    '/ill/items',                           to: 'ill#index'
      #post   '/ill/items',                           to: 'ill#create'
      #put    '/ill/items/:item_id/archive',          to: 'ill#archive'
      #patch  '/ill/items/:item_id/update_order',     to: 'ill#update_order'
      #get    '/ill/archived_items',                  to: 'ill#archived_index'
      #put    '/ill/archived_items/:item_id/restore', to: 'ill#archived_restore'
      #delete '/ill/archived_items/:item_id',         to: 'ill#archived_destroy'
      #delete '/ill/archived_items',                  to: 'ill#archived_destroy_all'
    end
  end
end
