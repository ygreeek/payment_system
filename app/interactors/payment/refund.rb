# frozen_string_literal: true

module Payment
  class Refund < BaseInteractor
    before :build_refund_transaction

    delegate :refund_transaction, :refund_transaction=, :charge_transaction, to: :context
    delegate :transaction, to: ActiveRecord::Base

    def call
      return fail!('Refund has not been authorized') unless authorize?

      success
    end

    protected

    def fail!(msg)
      super
      refund_transaction.update!(status: :error)
    end

    def success
      transaction do
        charge_transaction.update!(status: :refunded)
        refund_transaction.update!(status: :approved)
      end
    end

    private

    def build_refund_transaction
      self.refund_transaction = charge_transaction.dup.becomes!(Transaction::Refund)
      refund_transaction.charge = charge_transaction
      refund_transaction.status = nil
    end

    def authorize?
      return false if charge_transaction.nil?

      charge_transaction.approved?
    end
  end
end
