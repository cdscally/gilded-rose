require './lib/gilded_rose'

describe GildedRose do

  before(:each) do
    @items = [Item.new("Aged Brie", 10, 10), #should update to 11
              Item.new("Aged Brie", 10, 50), #should stay at 50
              Item.new("Sulfuras, Hand of Ragnaros", 0, 10), #should stay at 10
              Item.new("Backstage passes to a TAFKAL80ETC concert", 20, 10), #should update to 11
              Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 10), #should update to 12
              Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10), #should update to 13
              Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10), #should drop to 0
              Item.new("Snazzy jodhpurs", 10, 10), #shoudl update to 9
              Item.new("Indefinite pinata", -1, 10), #should update to 8
              Item.new("Lovely ham", -1, 0) #should stay at 0
             ]
  end

  describe "#update_quality" do
    it "does not change the name" do
      GildedRose.new(@items).update_quality()
      expect(@items[0].name).to eq "Aged Brie"
    end

    it "increases quality of 'Aged Brie'" do
      expect{ GildedRose.new(@items).update_quality() }.to change{ @items[0].quality }.from(10).to(11)
    end

    it "has maximum quality of 50 for 'Aged Brie'" do
      expect{ GildedRose.new(@items).update_quality() }.not_to change{ @items[1].quality }
    end

    it "does not change the quality of 'Sulfuras'" do
      expect{ GildedRose.new(@items).update_quality() }.not_to change{ @items[2].quality }
    end

    it "increases quality of 'Backstage pass' by 1 if sell-in is greater than 10" do
      expect{ GildedRose.new(@items).update_quality() }.to change{ @items[3].quality }.from(10).to(11)
    end

    it "increases quality of 'Backstage pass' by 2 if sell-in is between 6 and 10" do
      expect{ GildedRose.new(@items).update_quality() }.to change{ @items[4].quality }.from(10).to(12)
    end

    it "increases quality of 'Backstage pass' by 3 if sell-in is between 0 and 5" do
      expect{ GildedRose.new(@items).update_quality() }.to change{ @items[5].quality }.from(10).to(13)
    end

    it "sets quality of 'Backstage pass' to 0 if sell-in 0 or below" do
      expect{ GildedRose.new(@items).update_quality() }.to change{ @items[6].quality }.from(10).to(0)
    end

    it "reduces the quality of a 'general' item by 1 before sell-in date has passed" do
      expect{ GildedRose.new(@items).update_quality() }.to change{ @items[7].quality }.from(10).to(9)
    end

    it "reduces the quality of a 'general' item by 2 after sell-in date has passed" do
      expect{ GildedRose.new(@items).update_quality() }.to change{ @items[8].quality }.from(10).to(8)
    end

    it "will not reduce quality of a 'general' item below 0" do
      expect{ GildedRose.new(@items).update_quality() }.not_to change{ @items[9].quality }
    end

  end


end
