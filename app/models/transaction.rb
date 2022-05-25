# frozen_string_literal: true

class Transaction < ApplicationRecord
  TYPES = %w[
    authorize
    charge
    refund
    reversal
  ].freeze

  belongs_to :merchant

  enum status: {
    approved: 'approved',
    reversed: 'reversed',
    refunded: 'refunded',
    error: 'error'
  }

  validates :customer_email, format: { with: Devise.email_regexp }

  scope :web, -> { where.not(type: :authorize, status: :error) }
  scope :by_merchant, ->(merchant) { web.where(merchant: merchant) }

  TYPES.each do |type_name|
    define_method "#{type_name}?" do
      type_name == type&.demodulize&.downcase
    end
  end
end
