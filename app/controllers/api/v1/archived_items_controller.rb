module Api
  module V1
    class ArchivedItemsController < ApplicationController
      def index
        items = ArchivedItem.fetchAllItem
        render_200 'loaded archived items', items
      end

      def restore
        restored_item = ArchivedItem.restore_item(params['item_id'])
        render_200 'restored item', restored_item
      end

      def destroy
        ArchivedItem.delete_item(params['item_id'])
        render_200 'deleted item'
      end

      def destroy_all
        ArchivedItem.delete_all
        render_200 'deleted all archived item'
      end
    end
  end
end
