class BalanceTransaction < ApplicationRecord
  belongs_to :user
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :amount_scale_is_one

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
    unless amount == amount.round(2)
      errors.add(:base, 'You can only input amount up to scale of 2 (e.g. 20, 20.3, 20.25)')
    end
  end
end
