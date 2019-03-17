class Item < ApplicationRecord
  # extend: 引数のモジュールのメソッドを、クラスメソッドとして追加する
  extend BasicItem

  def self.archive_item(item_id)
    deleted_item = delete_item(item_id)
    ArchivedItem.add_item(deleted_item.title)
  end
end
