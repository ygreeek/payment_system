# frozen_string_literal: true

module Payment
  class Authorize < BaseInteractor
    before :build_authorize_transaction

    delegate :authorize_transaction, :authorize_transaction=, to: :context

    def call
      return fail!('Customer has insufficient funds') unless context.customer.withdraw(context.amount)

      success
    end

    protected

    def fail!(msg)
      super
      authorize_transaction.update!(status: :error)
    end

    def success
      authorize_transaction.update!(status: :approved)
    end

    private

    def build_authorize_transaction
      self.authorize_transaction = Transaction::Authorize.new(
        amount: context.amount,
        customer_email: context.customer_email,
        customer_phone: context.customer_phone,
        merchant: context.merchant
      )
    end
  end
end
