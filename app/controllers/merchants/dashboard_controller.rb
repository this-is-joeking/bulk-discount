# frozen_string_literal: true

module Merchants
  class DashboardController < ApplicationController
    def show
      if params[:commit] == 'Go to Merchant Dashboard'
        redirect_to merchant_dashboard_path(params[:merchant_id])
      else
        @merchant = Merchant.find(params[:id])
      end
    end
  end
end
