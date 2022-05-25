# frozen_string_literal: true

class Transaction::Charge < Transaction
  has_one :refund
  belongs_to :authorize, foreign_key: 'parent_id'
end
