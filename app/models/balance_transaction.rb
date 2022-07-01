class BalanceTransaction < ApplicationRecord
  belongs_to :user
  validates :amount, presence: true, numericality: { greater_than: 0 }

  enum transaction_type: %i[deposit withdraw]

  def deposit_type
    self.transaction_type = 0
    self
  end

  def withdraw_type
    self.transaction_type = 1
    self
  end
end
