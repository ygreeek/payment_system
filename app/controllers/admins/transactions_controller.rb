# frozen_string_literal: true

module Admins
  class TransactionsController < ApplicationController
    def index
      render template: 'admins/transactions/index', locals: { transactions: transactions }
    end

    private

    def transactions
      Transaction.web
    end
  end
end
