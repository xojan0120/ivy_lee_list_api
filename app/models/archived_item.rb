class ArchivedItem < ApplicationRecord
  extend BasicItem

  def self.restore_item(item_id)
    deleted_item = ArchivedItem.delete_item(item_id)
    Item.add_item(deleted_item.title)
  end
end
