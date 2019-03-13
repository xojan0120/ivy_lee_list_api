class Item < ApplicationRecord
  validates :title, presence: true

  def self.addItem(title)
    update_all("order_number = order_number + 1")
    added_item = create(title: title, order_number: 0)
  end

  # レコード順序入れ替え(参考：https://teratail.com/questions/117201)
  def self.moveItem(itemId, from , to)
    find(itemId).update_attribute(:order_number, to)
    if from > to
      where("order_number >= :to AND order_number < :from",{ from: from, to: to })
        .where.not(id: itemId) 
        .update_all("order_number = order_number + 1")
    else
      where("order_number > :from AND order_number <= :to",{ from: from, to: to })
        .where.not(id: itemId) 
        .update_all("order_number = order_number - 1")
    end
  end

  def self.deleteItem(itemId)
    deleted_item = find(itemId).destroy
    where("order_number > ?", deleted_item.order_number)
      .update_all("order_number = order_number - 1")
    deleted_item
  end
end
