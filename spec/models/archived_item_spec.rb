require 'rails_helper'

RSpec.describe ArchivedItem, type: :model do

  it "有効なファクトリを持つこと" do
    expect(FactoryBot.build(:archived_item)).to be_valid
  end

  it "アイテムがレストアできること" do
    item = FactoryBot.create(:archived_item)
    expect {
      ArchivedItem.restore_item(item.id)
    }.to change {
      Item.count
    }.by(1)
  end
end
