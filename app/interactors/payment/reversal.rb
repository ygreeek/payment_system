# frozen_string_literal: true

module Payment
  class Reversal < BaseInteractor
    before :build_reversal_transaction

    delegate :reversal_transaction, :reversal_transaction=, :authorize_transaction, to: :context
    delegate :transaction, to: ActiveRecord::Base

    def call
      return fail!('Reversal has not been authorized') unless authorize?

      success
    end

    protected

    def fail!(msg)
      super
      reversal_transaction.update!(status: :error)
    end

    def success
      transaction do
        authorize_transaction.update!(status: :reversed)
        reversal_transaction.update!(status: :approved)
      end
    end

    private

    def build_reversal_transaction
      self.reversal_transaction = authorize_transaction.dup.becomes!(Transaction::Reversal)
      reversal_transaction.authorize = authorize_transaction
      reversal_transaction.status = nil
      reversal_transaction.amount = nil
    end

    def authorize?
      return false if authorize_transaction.nil?

      authorize_transaction.approved?
    end
  end
end
