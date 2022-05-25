# frozen_string_literal: true

class Customer < ApplicationRecord
  validates :total_amount, numericality: true
  validates :email, format: { with: Devise.email_regexp }, uniqueness: true

  def can_afford?(amount)
    amount <= total_amount
  end

  def withdraw(amount)
    if can_afford?(amount)
      update(total_amount: total_amount - amount)
      true
    else
      false
    end
  end

  def deposite(amount)
    update(total_amount: total_amount + amount)
  end
end
