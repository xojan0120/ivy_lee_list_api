module Api
  module V1
    class ItemsController < ApplicationController
      def index
        items = Item.select(:id, :title).order(order_number: :asc)
        render json: { status: 200, message: 'loaded items', data: items }
      end

      def create
        added_item = Item.add_item(params['title'])
        render json: { status: 200, message: 'added item', data: added_item }
      end

      def archive
        deleted_item = Item.delete_item(params['item_id'])
        ArchivedItem.add_item(deleted_item.title)
        render json: { status: 200, message: 'archived item', data: {} }
      end

      def update_order
        Item.move_item(params['item_id'], params['from'], params['to'])
        render json: { status: 200, message: 'moved item', data: {} }
      end

      def update_title
        Item.find(params['item_id']).update_attribute(:title, params['title'])
        render json: { status: 200, message: 'changed item', data: {} }
      end
    end
  end
end
