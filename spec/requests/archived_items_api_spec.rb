require 'rails_helper'

describe "Archived Items API", type: :request do
  it "アイテムを全件読み出せること" do
    FactoryBot.create(:archived_item)
    FactoryBot.create(:archived_item)

    get api_v1_ill_archived_items_path
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['data'].length).to eq 2
  end

  it "アイテムをレストアできること" do
    # アーカイブ
    item = FactoryBot.create(:archived_item)

    api_path = File.join(api_v1_ill_archived_items_path, item.id.to_s, "restore")

    # レストア
    expect {
      put api_path
    }.to change(ArchivedItem, :count).by(-1)
    .and change(Item,         :count).by(1)
    expect(response).to have_http_status(200)

    expect(Item.first.title).to eq item.title
  end

  it "アイテムを削除できること" do
    item = FactoryBot.create(:archived_item)
    expect {
      delete api_v1_ill_archived_items_path(item.id)
    }.to change(ArchivedItem, :count).by(-1)
    expect(response).to have_http_status(200)
  end

  it "アイテムを全削除できること" do
    FactoryBot.create_list(:archived_item, 2)
    expect {
      delete api_v1_ill_archived_items_path
    }.to change(ArchivedItem, :count).by(-2)
    expect(response).to have_http_status(200)
  end
end
