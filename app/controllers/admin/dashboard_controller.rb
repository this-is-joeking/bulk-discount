# frozen_string_literal: true

module Admin
  class DashboardController < ApplicationController
    def index
      @top_customers = Customer.top_5_by_transactions
      @incomplete_invoices = Invoice.incomplete_invoices
    end
  end
end
