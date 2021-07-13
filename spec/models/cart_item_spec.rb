#frozen_string_literal: true

require "rails_helper"

RSpec.describe CartItem, "モデルに関するテスト", type: :model do
  describe "実際に保存してみる" do
    it "有効な投稿内容の場合は保存されるか" do
      expect(FactoryBot.build(:cart_item)).to be_valid
    end
  end
  describe "バリデーションのテスト" do
    subject { cart_item.valid? } #subjectで定義したものは、遅延評価となり、後から出てくるis_expectedに代入される

    let(:customer) { FactoryBot.create(:customer) }
    let(:item) { FactoryBot.create(:item) }
    let!(:cart_item) { build(:cart_item, customer_id: customer.id, item_id: item.id) }

    context 'quantityカラムのテスト' do
      it '空欄でないこと' do
        cart_item.quantity = ''
        is_expected.to eq false
      end
    end

  end

  describe 'アソシエーションのテスト' do
    context 'Customerモデルとの関係' do
      it 'N:1となっている' do
        expect(CartItem.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end

    context 'Itemモデルとの関係' do
      it 'N:1となっている' do
        expect(CartItem.reflect_on_association(:item).macro).to eq :belongs_to
      end
    end
  end
end