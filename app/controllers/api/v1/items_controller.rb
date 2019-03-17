module Api
  module V1
    class ItemsController < ApplicationController
      def index
        items = Item.fetchAllItem
        render_200 'loaded items', items
      end

      def create
        added_item = Item.add_item(params['title'])
        render_200 'added item', added_item
      end

      def archive
        # トランザクションについてメモ
        #
        # 例えば下記のような場合
        #   1. Item.delete_itemに成功
        #   2. ArchivedItem.add_itemに失敗
        #   結果: Itemが削除されただけの状態になってしまい不整合発生
        #
        # [対策1]
        #   下記のようにtransactionで囲めば、transactionブロック内で
        #   エラーが発生した場合、ブロック内での変更はロールバックされる。
        #   transaction do
        #     deleted_item = Item.delete_item(params['item_id'])
        #     ArchivedItem.add_item(deleted_item.title)
        #   end
        #
        # [対策2] (採用)
        #   Itemクラス内でItem.delete_itemとArchivedItem.add_itemする。
        #   Itemクラス内でエラーが発生した場合、クラス内での変更は
        #   ロールバックされる。
        
        Item.archive_item(params['item_id'])
        render_200 'archived item'
      end

      def update_order
        Item.move_item(params['item_id'], params['from'], params['to'])
        render_200 'moved item'
      end

      def update_title
        Item.change_item(params['item_id'], params['title'])
        render_200 'changed item'
      end
    end
  end
end
