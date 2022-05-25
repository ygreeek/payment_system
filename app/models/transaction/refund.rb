# frozen_string_literal: true

class Transaction::Refund < Transaction
  belongs_to :charge, foreign_key: 'parent_id'
end
