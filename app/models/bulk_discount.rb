class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates_numericality_of :discount, less_than: 100, greater_than: 0, only_integer: true
  validates_numericality_of :qty_threshold, greater_than: 1, only_integer: true
end