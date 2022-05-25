# frozen_string_literal: true

module Merchants
  class TransactionsController < ApplicationController
    def index
      render template: 'merchants/transactions/index', locals: { transactions: transactions }
    end

    private

    def transactions
      Transaction.web.by_merchant(current_merchant)
    end
  end
end
