module Api
  module V1
    class ItemsController < ApplicationController
      def index
        items = Item.select(:id, :title).order(order_number: :asc)
        render json: { status: 'SUCCESS', message: 'loaded items', data: items }
      end

      def create
        added_item = Item.add_item(params['title'])
        render json: { status: 'SUCCESS', message: 'added item', data: added_item }
      end

      def archive
        deleted_item = Item.delete_item(params['item_id'])
        ArchivedItem.add_item(deleted_item.title)
        render json: { status: 'SUCCESS', message: 'archived item', data: {} }
      end

      def update_order
        Item.move_item(params['item_id'], params['from'], params['to'])
        render json: { status: 'SUCCESS', message: ' moved item', data: {} }
      end
    end
  end
end
