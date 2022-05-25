# frozen_string_literal: true

class MerchantsController < ::Merchants::ApplicationController
  def show
    current_merchant
  end

  def edit
    current_merchant
  end

  def update
    if current_merchant.update(merchant_params)
      redirect_to merchant
    else
      render :edit
    end
  end

  def destroy; end

  private

  def merchant_params
    @merchant_params ||= params
                         .require(:merchant)
                         .permit(:name, :description, :email, :password, :password_confirmation)
  end
end
