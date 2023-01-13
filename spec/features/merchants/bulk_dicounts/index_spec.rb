require 'rails_helper'

RSpec.describe 'merchant/bulk discounts index page' do
  before(:each) do
    @merchant1 = Merchant.find(1)
    @merchant2 = Merchant.find(2)
    @bd1 = @merchant1.bulk_discounts.create!(discount: 99, qty_threshold: 1000)
    @bd2 = @merchant1.bulk_discounts.create!(discount: 18, qty_threshold: 15)
    @bd3 = @merchant1.bulk_discounts.create!(discount: 20, qty_threshold: 25)
    @bd4 = @merchant2.bulk_discounts.create!(discount: 1, qty_threshold: 2)
  end

  it 'lists all discounts that belong to the merchant and a link to the discounts show page' do
    visit merchant_bulk_discounts_path(@merchant1)

    @merchant1.bulk_discounts.each do |bd|
      within "#bd-#{bd.id}" do
        expect(page).to have_content("#{bd.discount}%")
        expect(page).to have_content("#{bd.qty_threshold} items")
        expect(page).to have_link("View", href: merchant_bulk_discount_path(@merchant1, bd))
      end
    end
  end

end
