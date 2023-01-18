# frozen_string_literal: true

module Admin
  class InvoicesController < ApplicationController
    def index
      @invoices = Invoice.all
    end

    def show
      @invoice = Invoice.find(params[:id])
    end

    def update
      invoice = Invoice.find(params[:id])
      invoice.update!(invoice_params)

      redirect_to "/admin/invoices/#{invoice.id}"
    end

    private

    def invoice_params
      params.permit(:status)
    end
  end
end
