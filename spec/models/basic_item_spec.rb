require 'rails_helper'

RSpec.describe BasicItem, type: :model do

  let!(:item_sep) { FactoryBot.create(:item, :separator) }

  it "全てのアイテムをorder_numberの昇順で返すこと" do
    item1    = FactoryBot.create(:item, order_number: 0)
    Item.find(item_sep.id).update_attribute(:order_number, 1)
    item2    = FactoryBot.create(:item, order_number: 2)
    items    = [item1, item_sep, item2]

    expect(Item.fetchAllItem).to match(items)
  end

  describe "アイテム追加について" do
    it "追加したアイテムを返すこと" do
      title = "test"
      added_item = Item.add_item(title)
      expect(added_item[:title]).to eq title
    end

    it "既存のアイテムの順序番号が全て+1されること" do
      item1 = FactoryBot.create(:item)
      item2 = FactoryBot.create(:item)

      Item.add_item("test")

      items = [item_sep, item1, item2]

      items.each do |item|
        expect(Item.find(item.id).order_number).to eq (item.order_number + 1)
      end
    end
  end

  describe "アイテム削除について" do
    let!(:item1) { FactoryBot.create(:item, order_number: 1) } 
    let!(:item2) { FactoryBot.create(:item, order_number: 2) }
    let!(:item3) { FactoryBot.create(:item, order_number: 3) } 

    it "削除したアイテムを返すこと" do
      deleted_item = Item.delete_item(item2.id)
      expect(deleted_item[:title]).to eq item2.title
    end

    describe "削除したアイテムより順序が前のアイテムについて" do
      it "アイテムの順序番号は変化していないこと" do
        expect {
          Item.delete_item(item2.id)
        }.to_not change {
          Item.find(item1.id).order_number
        }
      end
    end

    describe "削除したアイテムより順序が後のアイテムについて" do
      it "アイテムの順序番号は-1されていること" do
        expect {
          Item.delete_item(item2.id)
        }.to change {
          Item.find(item3.id).order_number
        }.from(3).to(2)
      end
    end
  end

  describe "アイテム順序入れ替えについて" do
    let!(:item1) { FactoryBot.create(:item, order_number: 1) }
    let!(:item2) { FactoryBot.create(:item, order_number: 2) }
    let!(:item3) { FactoryBot.create(:item, order_number: 3) }
    let!(:item4) { FactoryBot.create(:item, order_number: 4) }

    describe "移動元アイテムより前にあるアイテムについて" do
      it "順序番号は変化していないこと" do
        expect {
          Item.move_item(item2.id, 2, 3)
        }.to_not change {
          Item.find(item1.id).order_number
        }
      end
    end

    describe "移動先アイテムについて" do
      it "順序番号は-1されていること" do
        expect {
          Item.move_item(item2.id, 2, 3)
        }.to change {
          Item.find(item3.id).order_number
        }.from(3).to(2)
      end
    end

    describe "移動先アイテムより後にあるアイテムについて" do
      it "順序番号は変化していないこと" do
        expect {
          Item.move_item(item2.id, 2, 3)
        }.to_not change {
          Item.find(item4.id).order_number
        }
      end
    end
  end

  it "アイテムのタイトルが変更できること" do
    item        = FactoryBot.create(:item)
    after_title = item.title + "change"

    expect {
      Item.change_item(item.id, after_title)
    }.to change {
      Item.find(item.id).title
    }.from(item.title).to(after_title)
  end

end
