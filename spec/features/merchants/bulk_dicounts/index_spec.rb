# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'merchant/bulk discounts index page' do
  before(:each) do
    @merchant1 = Merchant.find(1)
    @merchant2 = Merchant.find(2)
    @bd1 = @merchant1.bulk_discounts.create!(discount: 99, qty_threshold: 1000)
    @bd2 = @merchant1.bulk_discounts.create!(discount: 18, qty_threshold: 15)
    @bd3 = @merchant1.bulk_discounts.create!(discount: 20, qty_threshold: 25)
    @bd4 = @merchant2.bulk_discounts.create!(discount: 11, qty_threshold: 7)
  end

  it 'lists all discounts that belong to the merchant and a link to the discounts show page' do
    visit merchant_bulk_discounts_path(@merchant1)

    @merchant1.bulk_discounts.each do |bd|
      within "#bd-#{bd.id}" do
        expect(page).to have_content("#{bd.discount}%")
        expect(page).to have_content("#{bd.qty_threshold} items")
        expect(page).to have_link('View', href: merchant_bulk_discount_path(@merchant1, bd))
      end
    end
    expect(page).to_not have_content('11% off with purchase of 7 items')
  end

  it 'has a link to create a new bulk discount' do
    visit merchant_bulk_discounts_path(@merchant1)

    expect(page).to have_link('Create a New Bulk Discount', href: new_merchant_bulk_discount_path(@merchant1))
  end

  it 'has a link to delete each bulk discount' do
    visit merchant_bulk_discounts_path(@merchant1)

    expect(page).to have_content(@bd1.discount)
    expect(page).to have_content(@bd1.qty_threshold)

    @merchant1.bulk_discounts.each do |bd|
      within "#bd-#{bd.id}" do
        expect(page).to have_link('Delete', href: merchant_bulk_discount_path(@merchant1, bd))
      end
    end

    within "#bd-#{@bd1.id}" do
      click_link 'Delete'
    end

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
    expect(page).to_not have_content(@bd1.discount)
    expect(page).to_not have_content(@bd1.qty_threshold)
  end

  it 'has a section for upcoming holidays that lists the next 3 holidays' do
    visit merchant_bulk_discounts_path(@merchant1)

    expect(page).to have_content('Upcoming Holidays')
    expect(page).to have_content('Juneteenth 2023-06-19')
    expect(page).to have_content('Good Friday 2023-04-07')
    expect(page).to have_content('Memorial Day 2023-05-29')
  end
end
