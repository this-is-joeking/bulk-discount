module Merchants
  class InvoicesController < ApplicationController
    def index
      @merchant = Merchant.find(params[:merchant_id])
      @invoices = @merchant.distinct_invoices
    end

    def show
      @merchant = Merchant.find(params[:merchant_id])
      @invoice = Invoice.find(params[:id])
    end
  end
end
