require 'rails_helper'

RSpec.describe Invoice do
  describe 'Relationships' do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    
  end

  describe 'Class Methods' do
    describe 'incomplete_invoices' do
      it 'returns the invoices with not shipped items in order by oldest' do
        expect(Invoice.incomplete_invoices).to be_a ActiveRecord::Relation
        expect(Invoice.incomplete_invoices.count).to eq 70
        expect(Invoice.incomplete_invoices.first).to eq(Invoice.find(10))
      end
    end
  end

  describe 'Instance Methods' do
    describe '#total_invoice_revenue' do
      it 'returns the total revenue for a specific invoice' do
        expect(Invoice.find(31).total_invoice_revenue).to eq('$28,499.29')
        expect(Invoice.find(1).total_invoice_revenue).to eq('$21,067.77')
      end
    end

    describe '#total_discounted_revenue' do
      it 'returns the total revenue less applicable bulk discounts' do
        invoice = Invoice.find(1)
        merchant = Merchant.find(1)
        merchant.bulk_discounts.create!(discount: 10, qty_threshold: 9)

        merchant1 = Merchant.create!(name: 'ShoeLaLa')
        bd = merchant1.bulk_discounts.create!(discount:20, qty_threshold: 10)
        itm = merchant1.items.create!(name: 'NewBalance 525', description: 'Classic Dad shoe', unit_price: 10000)
        cust = Customer.find(1)
        invoice1 = cust.invoices.create!(status: 2)
        ii = invoice1.invoice_items.create!(quantity: 10, unit_price: 10000, status: 2, item_id: itm.id)

        expect(invoice1.total_discounted_revenue).to eq(80_000)
        expect(invoice.total_discounted_revenue).to eq(2_085_785)
      end
    end
  end
end
