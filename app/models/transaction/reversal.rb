# frozen_string_literal: true

class Transaction::Reversal < Transaction
  belongs_to :authorize, foreign_key: 'parent_id'
end
