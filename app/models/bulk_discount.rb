# frozen_string_literal: true

class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
  validates_numericality_of :discount, less_than: 100, greater_than: 0, only_integer: true
  validates_numericality_of :qty_threshold, greater_than: 1, less_than: 100_000, only_integer: true
end
