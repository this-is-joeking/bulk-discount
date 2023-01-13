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
        expect(page).to have_link("View", href: merchant_bulk_discount_path(@merchant1, bd))
      end
    end
    expect(page).to_not have_content(@bd4.discount)
    expect(page).to_not have_content(@bd4.qty_threshold)
  end

  it 'has a link to create a new bulk discount' do
    visit merchant_bulk_discounts_path(@merchant1)

    expect(page).to have_link("Create a New Bulk Discount", href: new_merchant_bulk_discount_path(@merchant1))
  end

end

# As a merchant When I visit my bulk discounts index 
# Then I see a link to create a new discount 
# When I click this link Then I am taken to a new page where 
# I see a form to add a new bulk discount 
# When I fill in the form with valid data 
# Then I am redirected back to the bulk discount index 
# And I see my new bulk discount listed 