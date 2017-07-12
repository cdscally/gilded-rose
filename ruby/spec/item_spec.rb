require './lib/item'

describe Item do

  before(:each) do
    @item = Item.new("longsword", 10, 10)
  end

  it "creates a new item" do
    expect(@item).to respond_to(:to_s)
  end

  it "can represent item names, sell-in values and quality values as a string" do
    expect(@item.to_s).to eq("longsword, 10, 10")
  end
end
