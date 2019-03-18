require 'rails_helper'

describe "Items API", type: :request do

  let!(:item_sep) { FactoryBot.create(:item, :separator) }

  it "アイテムを全件読み出せること" do
    FactoryBot.create(:item)

    get api_v1_ill_items_path
    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['data'].length).to eq 2
  end

  it "アイテムを作成できること" do
    title = "test1"
    params = { title: title }

    expect {
      post api_v1_ill_items_path, params: params
    }.to change(Item, :count).by(1)
    expect(response).to have_http_status(200)

    expect(Item.last.title).to eq title
  end

  it "アイテムをアーカイブできること" do
    item = FactoryBot.create(:item)

    expect {
      put api_v1_path(item.id)
    }.to change(Item,         :count).by(-1)
    .and change(ArchivedItem, :count).by(1)
    expect(response).to have_http_status(200)

    expect(ArchivedItem.last.title).to eq item.title
  end

  it "アイテムの順序を入れ替えできること(現在順序より前へ)" do
    item1    = FactoryBot.create(:item, order_number: 1)
    item2    = FactoryBot.create(:item, order_number: 2)

    api_path = api_v1_path(item1.id).sub(/archive$/, "order")

    # item_sepとitem1の順序が入れ替わっていること
    params = { from: 1, to: 0 }
    expect {
      patch api_path, params: params
    }.to change {
      Item.find(item1.id).order_number
    }.from(params[:from]).to(params[:to])
    .and change {
      Item.find(item_sep.id).order_number
    }.from(params[:to]).to(params[:from])

    # item2の順序には影響がないこと
    expect(Item.find(item2.id).order_number).to eq item2.order_number

    expect(response).to have_http_status(200)
  end

  it "アイテムの順序を入れ替えできること(現在順序より後へ)" do
    item1    = FactoryBot.create(:item, order_number: 1)
    item2    = FactoryBot.create(:item, order_number: 2)

    api_path = api_v1_path(item1.id).sub(/archive$/, "order")

    # item1とitem2の順序が入れ替わっていること
    params = { from: 1, to: 2 }
    expect {
      patch api_path, params: params
    }.to change {
      Item.find(item1.id).order_number
    }.from(params[:from]).to(params[:to])
    .and change {
      Item.find(item2.id).order_number
    }.from(params[:to]).to(params[:from])

    # item_sepの順序には影響がないこと
    expect(Item.find(item_sep.id).order_number).to eq item_sep.order_number

    expect(response).to have_http_status(200)
  end

  it "アイテムのタイトルを変更できること" do
    item = FactoryBot.create(:item)

    api_path = api_v1_path(item.id).sub(/archive$/, "title")

    after_title = item.title + "after"
    params = { title: after_title }
    expect {
      patch api_path, params: params
    }.to change {
      Item.find(item.id).title
    }.from(item.title).to(after_title)

    expect(response).to have_http_status(200)
  end

end
