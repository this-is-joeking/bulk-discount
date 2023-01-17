require 'rails_helper'

RSpec.describe BulkDiscount do
  describe 'relationships' do
    it {should belong_to :merchant}
    it {should have_many(:items).through(:merchant)}
    it {should have_many(:invoice_items).through(:items)}
  end

  describe 'validations' do
    it {should validate_numericality_of :discount}
    it {should validate_numericality_of :qty_threshold}
  end
end