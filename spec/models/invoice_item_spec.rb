# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'Relationships' do
    it { should belong_to :invoice }
    it { should belong_to :item }
    it { should have_many(:transactions).through(:invoice) }
    it { should have_one(:merchant).through(:item) }
    it { should have_many(:bulk_discounts).through(:merchant) }
    it { should validate_numericality_of :quantity }
    it { should validate_numericality_of :unit_price }
  end

  describe '#unit_price_to_dollars' do
    it 'converts unit price to dollars' do
      expect(InvoiceItem.first.unit_price_to_dollars).to eq('$136.35')
    end
  end

  describe '#discounted?' do
    it 'returns a boolean confirming if a bulk discount applies to the invoice_item' do
      ii = InvoiceItem.find(1)
      ii2 = InvoiceItem.find(2)

      merchant = Merchant.find(1)

      expect(ii.discounted?).to eq false
      expect(ii2.discounted?).to eq false

      merchant.bulk_discounts.create!(discount: 10, qty_threshold: 9)

      expect(ii.discounted?).to eq false
      expect(ii2.discounted?).to eq true

      merchant1 = Merchant.create!(name: 'ShoeLaLa')
      merchant1.bulk_discounts.create!(discount: 20, qty_threshold: 10)
      itm = merchant1.items.create!(name: 'NewBalance 525', description: 'Classic Dad shoe', unit_price: 10_000)
      cust = Customer.find(1)
      invoice1 = cust.invoices.create!(status: 2)
      ii3 = invoice1.invoice_items.create!(quantity: 10, unit_price: 10_000, status: 2, item_id: itm.id)

      expect(ii3.discounted?).to eq true
    end
  end

  describe '#bulk_discount' do
    it 'if a discount applies it returns the single applicable discount for an invoice item' do
      merchant1 = Merchant.create!(name: 'ShoeLaLa')
      bd = merchant1.bulk_discounts.create!(discount: 10, qty_threshold: 5)
      itm = merchant1.items.create!(name: 'NewBalance 525', description: 'Classic Dad shoe', unit_price: 10_000)
      cust = Customer.find(1)
      invoice1 = cust.invoices.create!(status: 2)
      ii = invoice1.invoice_items.create!(quantity: 10, unit_price: 10_000, status: 2, item_id: itm.id)

      expect(ii.bulk_discount).to eq(bd)

      bd2 = merchant1.bulk_discounts.create!(discount: 20, qty_threshold: 10)

      expect(ii.bulk_discount).to eq(bd2)

      ii2 = InvoiceItem.find(1)

      expect(ii2.bulk_discount).to eq(nil)
    end
  end
end
