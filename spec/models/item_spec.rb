require 'rails_helper'

RSpec.describe Item, type: :model do

  it "有効なファクトリを持つこと" do
    expect(FactoryBot.build(:item)).to be_valid
  end

  it "アイテムがアーカイブできること" do
    item = FactoryBot.create(:item)
    expect {
      Item.archive_item(item.id)
    }.to change {
      ArchivedItem.count
    }.by(1)
  end
end
