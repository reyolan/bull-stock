class BalanceTransaction < ApplicationRecord
  belongs_to :user
  validates :amount, presence: true, numericality: { greater_than: 0 }

  enum transaction_type: %i[deposit withdraw]

  scope :deposits, -> { where(transaction_type: 0).order(created_at: :desc) }
  scope :withdrawals, -> { where(transaction_type: 1).order(created_at: :desc) }

  def deposit_type
    self.transaction_type = 0
    self
  end

  def withdraw_type
    self.transaction_type = 1
    self
  end
end
