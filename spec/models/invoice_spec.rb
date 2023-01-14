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
      end
    end

    describe '#total_discounted_revenue' do
      it 'returns the total revenue less applicable bulk discounts' do
        invoice = Invoice.find(1)

        expect(invoice.total_discounted_revenue).to eq(20_857.85)
      end
    end
  end
end
