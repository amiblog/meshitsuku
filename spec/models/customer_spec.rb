require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe '#create' do
    before do
      @customer = FactoryBot.build(:customer)
    end

    context '登録できる時' do
      it 'すべての項目の入力が存在すれば登録できる' do
        expect(@customer).to be_valid
      end

      it 'パスワードが６文字以上あれば登録できる' do
        @customer.password = 'aaaaaa'
        @customer.password_confirmation = 'aaaaaa'
        expect(@customer).to be_valid
      end
    end

    context '登録できない時' do
      it 'nameが空では登録できない' do
        @customer.name = ''
        @customer.valid?
      end

      it 'nicknameが空では登録できない' do
        @customer.nickname = ''
        @customer.valid?
      end

      it 'emailが空では登録できない' do
        @customer.email = ''
        @customer.valid?
      end

      it 'パスワードが空では登録できない' do
        @customer.password = ''
        @customer.valid?
      end

      it 'パスワードと確認用のパスワードが不一致だと登録できない' do
        @customer.password = '12345a'
        @customer.password_confirmation = '12345b'
        @customer.valid?
      end
    end
  end
end
