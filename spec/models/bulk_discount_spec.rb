require 'rails_helper'

RSpec.describe BulkDiscount do
  describe 'relationships' do
    it {should belong_to :merchant}
  end

  describe 'validations' do
    it {should validate_numericality_of :discount}
    it {should validate_numericality_of :qty_threshold}
  end

  it '' do
    require 'pry'; binding.pry
  end
end