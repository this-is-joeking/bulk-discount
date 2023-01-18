# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Merchants Invoices Index' do
  it 'lists all of the merchants invoices' do
    visit merchant_invoices_path(1)

    merchant = Merchant.find(1)
    expect(page).to have_content(merchant.name)
    merchant.invoices.each do |invoice|
      expect(page).to have_link(invoice.id.to_s, href: merchant_invoice_path(merchant, invoice)).once
    end
  end
end
