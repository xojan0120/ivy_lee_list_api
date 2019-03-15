module Api
  module V1
    class ArchivedItemsController < ApplicationController
      def index
        items = ArchivedItem.select(:id, :title).order(order_number: :asc)
        render json: { status: 200, message: 'loaded archived items', data: items }
      end

      def restore
        deleted_item = ArchivedItem.delete_item(params['item_id'])
        added_item = Item.add_item(deleted_item.title)
        render json: { status: 200, message: 'restored item', data: added_item }
      end

      def destroy
        ArchivedItem.delete_item(params['item_id'])
        render json: { status: 200, message: 'deleted item', data: {} }
      end

      def destroy_all
        ArchivedItem.delete_all
        render json: { status: 200, message: 'deleted all archived item', data: {} }
      end
    end
  end
end
