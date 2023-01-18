# frozen_string_literal: true

module Admin
  class MerchantsController < ApplicationController
    def index
      @merchants = Merchant.all
    end

    def show
      @merchant = Merchant.find(params[:id])
    end

    def edit
      @merchant = Merchant.find(params[:id])
    end

    def update
      merchant = Merchant.find(params[:id])

      if merchant.update(merchant_params)

        return redirect_to admin_merchants_path if params[:merchant][:enabled]

        redirect_to admin_merchant_path(merchant)
        flash[:notice] = 'Merchant name has been changed'
      else
        flash[:notice] = 'Merchant must have a name'
        redirect_to edit_admin_merchant_path(merchant)
      end
    end

    def new
      @merchant = Merchant.new
    end

    def create
      merchant = Merchant.new(merchant_params)

      if merchant.save
        redirect_to admin_merchants_path
      else
        flash[:notice] = 'Merchant must have a name'
        redirect_to new_admin_merchant_path
      end
    end

    private

    def merchant_params
      params.require(:merchant).permit(:name, :enabled)
    end
  end
end
