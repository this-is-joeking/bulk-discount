require 'rails_helper'

RSpec.describe 'merchant bulk_discount edit page' do
  before(:each) do
    @merchant1 = Merchant.find(1)
    @bd1 = @merchant1.bulk_discounts.create!(discount: 25, qty_threshold: 100)
  end

  it 'has a pre-populated form to edit/update the bulk discount' do
    visit edit_merchant_bulk_discount_path(@merchant1, @bd1)

    expect(page).to have_field('bulk_discount[discount]', with: @bd1.discount)
    expect(page).to have_field('bulk_discount[qty_threshold]', with: @bd1.qty_threshold)

    fill_in 'bulk_discount[discount]', with: '10'
    fill_in 'bulk_discount[qty_threshold]', with: '3'
    
    click_button 'Submit'

    expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @bd1))
    expect(page).to have_content("Discount: 10%")
    expect(page).to have_content("Quantity threshold for discount to apply: 3 items")
    expect(page).to have_content('Bulk Discount Updated')
  end

  it 'will provide error message and remain on edit page if given invalid attributes' do
    visit edit_merchant_bulk_discount_path(@merchant1, @bd1)

    fill_in 'bulk_discount[discount]', with: '-1'
    fill_in 'bulk_discount[qty_threshold]', with: '1'
    
    click_button 'Submit'

    expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @bd1))
    expect(page).to have_content('Discount must be greater than 0 and Qty threshold must be greater than 1')
  end
end
