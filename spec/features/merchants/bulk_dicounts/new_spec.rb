# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'merchants bulk discount new page' do
  before(:each) do
    @merchant1 = Merchant.find(1)
  end

  it 'has a form to create a new bulk discount' do
    visit new_merchant_bulk_discount_path(@merchant1)

    fill_in 'bulk_discount[discount]', with: '10'
    fill_in 'bulk_discount[qty_threshold]', with: '3'

    click_button 'Submit'

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
    expect(page).to have_content('10% off with purchase of 3 items')
  end

  it 'will display an appropriate error message if you enter something invalid on the form' do
    visit new_merchant_bulk_discount_path(@merchant1)

    fill_in 'bulk_discount[discount]', with: '150'
    fill_in 'bulk_discount[qty_threshold]', with: '1'

    click_button 'Submit'

    expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
    expect(page).to have_content('Discount must be less than 100 and Qty threshold must be greater than 1')
  end
end
