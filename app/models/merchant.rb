# frozen_string_literal: true

class Merchant < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :validatable

  has_many :transactions, as: :transactable
  has_many :customers, through: :transactions, source: :transactable, source_type: 'Customer'

  enum status: { active: 'active', inactive: 'inactive' }, _default: 'active'

  validates :name, :status, presence: true

  def total_transaction_sum
    Transaction::Charge.approved.sum(:amount) -
      Transaction::Refund.approved.joins(:charge).where(charge: { status: :refunded }).sum(:amount)
  end
end
