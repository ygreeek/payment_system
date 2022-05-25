# frozen_string_literal: true

class Transaction::Authorize < Transaction
  has_one :charge, foreign_key: 'parent_id'
end
