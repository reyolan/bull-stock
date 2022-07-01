class StockTransaction < ApplicationRecord
  belongs_to :user
  validates :quantity, presence: true, numericality: { greater_than: 0 }

  enum transaction_type: %i[buy sell]

  def buy_type
    self.transaction_type = 0
    calculate_total_amount
    self
  end

  def log_sell!
    self.transaction_type = 1
    save!
  end

  private

  def calculate_total_amount
    self.amount = quantity * unit_price
  end
end
