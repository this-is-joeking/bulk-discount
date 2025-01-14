# frozen_string_literal: true

class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :transactions, through: :invoice
  has_one :merchant, through: :item
  has_many :bulk_discounts, through: :merchant
  enum status: { pending: 0, packaged: 1, shipped: 2 }
  validates_numericality_of :quantity, :unit_price

  def unit_price_to_dollars
    number_to_currency(self.unit_price.to_f / 100)
  end

  def discounted?
    self.bulk_discounts.where('bulk_discounts.qty_threshold <= ?', self.quantity).present?
  end

  def bulk_discount
    self.bulk_discounts.where('bulk_discounts.qty_threshold <= ?',
                              self.quantity).order('bulk_discounts.discount desc').first
  end
end
