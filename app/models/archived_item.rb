class ArchivedItem < ApplicationRecord
  validates :title, presence: true

  def self.addItem(title)
    update_all("order_number = order_number + 1")
    create(title: title, order_number: 0)
  end

  def self.deleteItem(itemId)
    deleted_item = find(itemId).destroy
    where("order_number > ?", deleted_item.order_number)
      .update_all("order_number = order_number - 1")
    deleted_item
  end
end
