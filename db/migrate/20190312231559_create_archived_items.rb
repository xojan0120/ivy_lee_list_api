class CreateArchivedItems < ActiveRecord::Migration[5.1]
  def change
    create_table :archived_items do |t|
      t.string :title
      t.integer :order_number

      t.timestamps
    end
  end
end
