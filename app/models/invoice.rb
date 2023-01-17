class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :transactions, dependent: :destroy
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants
  enum status: { 'in progress' => 0, completed: 1, cancelled: 2 }

  def self.incomplete_invoices
    Invoice.left_joins(:invoice_items)
           .where.not(invoice_items: { status: 2 })
           .distinct.order(:updated_at)
  end

  def total_invoice_revenue
    number_to_currency(self.invoice_items.sum('invoice_items.quantity * invoice_items.unit_price') / 100.0)
  end

  def merchant_invoice_revenue(merchant)
    number_to_currency(self.items.where('items.merchant_id = ?', merchant.id)
      .sum('invoice_items.quantity * invoice_items.unit_price') / 100.0)
  end

  def total_discounted_revenue
  number_to_currency(self.invoice_items.left_joins(item: :bulk_discounts)
    .sum('0.01 * invoice_items.quantity * invoice_items.unit_price * (CASE 
      WHEN invoice_items.quantity >= bulk_discounts.qty_threshold 
      THEN (1 - bulk_discounts.discount / 100.00) 
      ELSE 1 
      END)'))
  end
end
