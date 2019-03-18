module BasicItem
  def fetchAllItem
    select(:id, :title).order(order_number: :asc)
  end

  def add_item(title)
    update_all("order_number = order_number + 1")
    added_item = create(title: title, order_number: 0)
    { id: added_item.id, title: added_item.title }
  end

  def delete_item(item_id)
    deleted_item = find(item_id).destroy
    where("order_number > ?", deleted_item.order_number)
      .update_all("order_number = order_number - 1")
    deleted_item
  end

  # レコード順序入れ替えロジック参考：https://teratail.com/questions/117201
  def move_item(item_id, from , to)
    find(item_id).update_attribute(:order_number, to)
    if from > to
      where("order_number >= :to AND order_number < :from", { from: from, to: to })
        .where.not(id: item_id) 
        .update_all("order_number = order_number + 1")
    else
      where("order_number > :from AND order_number <= :to", { from: from, to: to })
        .where.not(id: item_id) 
        .update_all("order_number = order_number - 1")
    end
  end

  def change_item(item_id, title)
    find(item_id).update_attribute(:title, title)
  end
end
