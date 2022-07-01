class BalanceTransaction < ApplicationRecord
  belongs_to :user
  validates :amount, presence: true, numericality: { greater_than: 0 }

  enum transaction_type: %i[deposit withdraw]

  def log_deposit!
    self.transaction_type = 0
    save!
  end

  def log_withdraw!
    self.transaction_type = 1
    save!
  end
end
