# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'merchants bulk discount show page' do
  before(:each) do
    @merchant1 = Merchant.find(1)
    @bd1 = @merchant1.bulk_discounts.create!(discount: 25, qty_threshold: 100)
  end

  it 'lists the discount percentage and quantity threshold' do
    visit merchant_bulk_discount_path(@merchant1, @bd1)

    expect(page).to have_content("Discount: #{@bd1.discount}%")
    expect(page).to have_content("Quantity threshold for discount to apply: #{@bd1.qty_threshold} items")
  end

  it 'has a link to edit the bulk discount' do
    visit merchant_bulk_discount_path(@merchant1, @bd1)

    expect(page).to have_link('Edit', href: edit_merchant_bulk_discount_path(@merchant1, @bd1))
  end
end
