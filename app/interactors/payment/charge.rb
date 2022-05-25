# frozen_string_literal: true

module Payment
  class Charge < BaseInteractor
    before :build_charge_transaction

    delegate :charge_transaction, :charge_transaction=, :authorize_transaction, to: :context

    def call
      return fail!('Charge has not been authorized') unless authorize?

      success
    end

    protected

    def fail!(msg)
      super
      charge_transaction.update!(status: :error)
    end

    def success
      charge_transaction.update!(status: :approved)
    end

    private

    def build_charge_transaction
      self.charge_transaction = authorize_transaction.dup.becomes!(Transaction::Charge)
      charge_transaction.authorize = authorize_transaction
      charge_transaction.status = nil
    end

    def authorize?
      return false if authorize_transaction.nil?

      authorize_transaction.approved?
    end
  end
end
