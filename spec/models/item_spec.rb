require 'rails_helper'
describe Item do
  describe '#create' do
    it "nameが空だと登録できない" do
      item = build(:item, name: nil)
      item.valid?
      expect(item.errors[:name]).to include("can't be blank")
    end

    it "descriptionが空だと登録できない" do
      item = build(:item, description: nil)
      item.valid?
      expect(item.errors[:description]).to include("can't be blank")
    end

    it "category_idが空だと登録できない" do
      item = build(:item, category_id: nil)
      item.valid?
      expect(item.errors[:category_id]).to include("can't be blank")
    end

    it "conditionが空だと登録できない" do
      item = build(:item, condition: nil)
      item.valid?
      expect(item.errors[:condition]).to include("can't be blank")
    end

    it "shipping_feeが空だと登録できない" do
      item = build(:item, shipping_fee: nil)
      item.valid?
      expect(item.errors[:shipping_fee]).to include("can't be blank")
    end

    it "shipping_methodが空だと登録できない" do
      item = build(:item, shipping_method: nil)
      item.valid?
      expect(item.errors[:shipping_method]).to include("can't be blank")
    end

    it "prefecture_idが空だと登録できない" do
      item = build(:item, prefecture_id: nil)
      item.valid?
      expect(item.errors[:prefecture_id]).to include("can't be blank")
    end

    it "shipping_dateが空だと登録できない" do
      item = build(:item, shipping_date: nil)
      item.valid?
      expect(item.errors[:shipping_date]).to include("can't be blank")
    end

    it "priceが空だと登録できない" do
      item = build(:item, price: nil)
      item.valid?
      expect(item.errors[:price]).to include("can't be blank")
    end

    it "statusが空だと登録できない" do
      item = build(:item, status: nil)
      item.valid?
      expect(item.errors[:status]).to include("can't be blank")
    end

    it "上記のカラムが全て存在すれば登録できる" do
      item = build(:item)
      expect(item).to be_valid
    end

    it "nameが40文字なら登録できる" do
      item = build(:item, name: "あいうえおアイウエオあいうえおアイウエオあいうえおアイウエオあいうえおアイウエオ")
      expect(item).to be_valid
    end

    it "nameが41文字なら登録できない" do
      item = build(:item, name: "！あいうえおアイウエオあいうえおアイウエオあいうえおアイウエオあいうえおアイウエオ")
      item.valid?
      expect(item.errors[:name]).to include("is too long (maximum is 40 characters)")
    end

    it "descriptionが1000文字なら登録できる" do
      item = build(:item, description: "ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんぁあぃい")
      expect(item).to be_valid
    end

    it "descriptionが1001文字なら登録できない" do
      item = build(:item, description: "！ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんぁあぃい")
      item.valid?
      expect(item.errors[:description]).to include("is too long (maximum is 1000 characters)")
    end

    it "priceが300なら登録できる" do
      item = build(:item, price: 300)
      expect(item).to be_valid
    end

    it "priceが299なら登録できない" do
      item = build(:item, price: 299)
      item.valid?
      expect(item.errors[:price]).to include("must be greater than or equal to 300")
    end

    it "priceが9999999なら登録できる" do
      item = build(:item, price: 9999999)
      expect(item).to be_valid
    end

    it "priceが10000000なら登録できない" do
      item = build(:item, price: 10000000)
      item.valid?
      expect(item.errors[:price]).to include("must be less than or equal to 9999999")
    end
    
  end
end