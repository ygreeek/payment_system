# frozen_string_literal: true

module Payment
  class Validate < BaseInteractor
    before { context.error_messages = [] }

    def call
      validate_merchant
      validate_customer
      validate_amount

      fail!("Payment is invalid: #{context.error_messages.join(', ')}") if context.error_messages.present?
    end

    private

    def validate_merchant
      context.merchant = Merchant.find_by(email: context.merchant_email)
      context.error_messages << 'Merchant does not exist' unless context.merchant
    end

    def validate_customer
      context.customer = Customer.where(email: context.customer_email)
                                 .or(Customer.where(phone: context.customer_phone))
                                 .first
      context.error_messages << 'Customer does not exist' unless context.customer
    end

    def validate_amount
      context.error_messages << 'Amount is invalid' if context.amount.to_f <= 0
    end
  end
end
