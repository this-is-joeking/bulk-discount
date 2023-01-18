# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Merchants Invoice Show' do
  it 'Shows all of the information for the specific invoice' do
    merchant = Merchant.find(1)
    invoice = merchant.invoices.first
    visit merchant_invoice_path(merchant, invoice)

    expect(page).to have_content(merchant.name)
    expect(page).to have_content(invoice.id)
    expect(page).to have_content(invoice.status.capitalize)
    expect(page).to have_content(invoice.created_at.strftime('%A, %B %-d, %Y'))
    expect(page).to have_content(invoice.customer.first_name)
    expect(page).to have_content(invoice.customer.last_name)
  end

  it 'Shows information for each individual item on the invoice' do
    merchant = Merchant.find(1)
    invoice = merchant.invoices.first
    visit merchant_invoice_path(merchant, invoice)

    invoice.items.each do |item|
      expect(page).to have_content(item.name).once
    end

    invoice.invoice_items.each do |invoice_item|
      expect(page).to have_content(invoice_item.quantity)
      expect(page).to have_content(invoice_item.unit_price_to_dollars)
      expect(page).to have_content(invoice_item.status.capitalize)
    end

    not_invoice = Merchant.find(2).invoices.second

    not_invoice.items.each do |item|
      expect(page).to_not have_content(item.name)
    end
  end

  it 'Shows the total revenue for the specific invoice' do
    visit merchant_invoice_path(Merchant.find(8), Invoice.find(31))

    expect(page).to have_content('Total invoice revenue: $28,499.29')
  end

  it 'Has a field to update the status of an item on the invoice' do
    visit merchant_invoice_path(Merchant.find(8), Invoice.find(31))

    invoice_item = Invoice.find(31).invoice_items.first

    expect(invoice_item.status).to eq('shipped')

    within("#item_#{invoice_item.id}") do
      expect(page).to have_select('invoice_item[status]', selected: 'Shipped')
      select('Pending', from: 'invoice_item[status]')
      click_button 'Update Item Status'
    end

    expect(current_path).to eq(merchant_invoice_path(Merchant.find(8), Invoice.find(31)))
    within("#item_#{invoice_item.id}") do
      expect(page).to have_content('Pending')
      expect(page).to have_select('invoice_item[status]', selected: 'Pending')
    end
  end

  it 'has a separate category  of total revenue including bulk discounts' do
    merchant = Merchant.find(1)
    invoice = merchant.invoices.first
    merchant.bulk_discounts.create!(discount: 10, qty_threshold: 9)
    visit merchant_invoice_path(merchant, invoice)

    expect(page).to have_content('Total invoice revenue: $21,067.77')
    expect(page).to have_content('Total invoice revenue including bulk discount(s): $20,857.85')
  end

  it 'has a link to the applied bulk discount show page next to invoice items with applicable discounts' do
    merchant = Merchant.find(1)
    invoice = merchant.invoices.first
    bd = merchant.bulk_discounts.create!(discount: 10, qty_threshold: 9)
    ii = invoice.invoice_items.find_by(quantity: 9)
    visit merchant_invoice_path(merchant, invoice)

    within "#item_#{ii.id}" do
      expect(page).to have_link('10% off applied', href: merchant_bulk_discount_path(merchant, bd))
    end

    expect(page).to have_link('10% off applied', href: merchant_bulk_discount_path(merchant, bd)).once
  end
end
