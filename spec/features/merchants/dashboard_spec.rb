# As a merchant,
# When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
# Then I see the name of my merchant
require 'rails_helper'

RSpec.describe "The Merchant Dashboard" do
  it 'Contains the name of the merchant' do
    merchant = Merchant.create!(name: 'Bobby')

    visit "/merchants/#{merchant.id}/dashboard"

    expect(page).to have_content(merchant.name)
  end
end