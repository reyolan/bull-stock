class StockTransaction < ApplicationRecord
  belongs_to :user
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  before_create :total_amount

  enum transaction_type: %i[buy sell]

  def save_buy!
    self.transaction_type = 0
    save!
  end

  def save_sell!
    self.transaction_type = 1
    save!
  end

  private

  def total_amount
    self.amount = quantity * unit_price
  end
end
