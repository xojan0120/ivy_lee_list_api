module Api
  module V1
    class IllController < ApplicationController
      def fetchAllItem
        items = Item.select(:id, :title).order(order_number: :asc)
        render json: { status: 'SUCCESS', message: 'loaded items', data: items }
      end

      def fetchAllArchivedItem
        items = ArchivedItem.select(:id, :title).order(order_number: :asc)
        render json: { status: 'SUCCESS', message: 'loaded archived items', data: items }
      end

      def addItem
        added_item = Item.addItem(params['title'])
        item = { id: added_item.id, title: added_item.title }
        render json: { status: 'SUCCESS', message: 'added item', data: item }
      end

      def moveItem
        Item.moveItem(params['itemId'], params['from'], params['to'])
        render json: { status: 'SUCCESS', message: ' moved item', data: {} }
      end

      def archiveItem
        deleted_item = Item.deleteItem(params['itemId'])
        ArchivedItem.addItem(deleted_item.title)
        render json: { status: 'SUCCESS', message: 'archived item', data: {} }
      end

      def restoreItem
        deleted_item = ArchivedItem.deleteItem(params['itemId'])
        added_item = Item.addItem(deleted_item.title)
        item = { id: added_item.id, title: added_item.title }
        render json: { status: 'SUCCESS', message: 'restored item', data: item }
      end

      def deleteItem
        ArchivedItem.deleteItem(params['itemId'])
        render json: { status: 'SUCCESS', message: 'deleted item', data: {} }
      end

      def deleteAllArchivedItem
        ArchivedItem.delete_all
        render json: { status: 'SUCCESS', message: 'deleted all archived item', data: {} }
      end
    end
  end
end
