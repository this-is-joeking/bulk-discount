class Merchants::BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])

    @bulk_discounts = @merchant.bulk_discounts

    @holidays = HolidayInfo.new
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])

    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    bd = merchant.bulk_discounts.new(bulk_discount_params)
    if bd.save
      redirect_to merchant_bulk_discounts_path(merchant)
    else
      flash[:notice] = bd.errors.full_messages.to_sentence

      redirect_to new_merchant_bulk_discount_path(merchant)
    end
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])

    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    bd = BulkDiscount.find(params[:id])

    if bd.update(bulk_discount_params)
      flash[:notice] = 'Bulk Discount Updated'
      redirect_to merchant_bulk_discount_path(merchant, bd)
    else
      flash[:notice] = bd.errors.full_messages.to_sentence

      redirect_to edit_merchant_bulk_discount_path(merchant, bd)
    end
  end

  def destroy
    bd = BulkDiscount.destroy(params[:id])
    redirect_to merchant_bulk_discounts_path(params[:merchant_id])
  end

  private

  def bulk_discount_params
    params.require(:bulk_discount).permit(:discount, :qty_threshold)
  end
end