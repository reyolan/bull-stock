class BalanceTransaction < ApplicationRecord
  belongs_to :user
  validate :amount_scale_is_one, :amount_is_positive

  enum transaction_type: %i[deposit withdraw]

  scope :deposits, -> { where(transaction_type: 0).desc_created_at }
  scope :withdrawals, -> { where(transaction_type: 1).desc_created_at }
  scope :desc_created_at, -> { order(created_at: :desc) }

  def deposit_type
    self.transaction_type = 0
    self
  end

  def withdraw_type
    self.transaction_type = 1
    self
  end

  private

  def amount_scale_is_one
    unless amount.to_i == amount.to_i.round(2)
      errors.add(:base, 'You can only input amount up to scale of 2 (e.g. 20, 20.3, 20.25)')
    end
  end

  def amount_is_positive
    errors.add(:base, 'Please input a valid amount') if amount.to_i.zero?
    errors.add(:base, 'An input of negative amount is not possible') if amount.to_i.negative?
  end
end
