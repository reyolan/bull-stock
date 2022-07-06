class StockTransaction < ApplicationRecord
  belongs_to :user
  validate :stock_quantity_is_positive, :stock_quantity_scale_is_one

  enum transaction_type: %i[buy sell]

  scope :buy_list, -> { where(transaction_type: 0).desc_created_at }
  scope :sell_list, -> { where(transaction_type: 1).desc_created_at }
  scope :desc_created_at, -> { order(created_at: :desc) }

  def buy
    self.transaction_type = 0
    self.amount = quantity.to_d * unit_price
    self
  end

  def sell
    self.transaction_type = 1
    self.amount = quantity.to_d * unit_price
    self
  end

  private

  def stock_quantity_is_positive
    errors.add(:base, 'Please input valid number of shares') if quantity.to_d.zero?
    errors.add(:base, 'An input of negative share is not possible') if quantity.to_d.negative?
  end

  def stock_quantity_scale_is_one
    unless quantity.to_d == quantity.to_d.round(1)
      errors.add(:base, 'You can only input number of shares up to scale of 1 (e.g. 1, 2, 1.5, 2.5)')
    end
  end
end
