class StockTransaction < ApplicationRecord
  belongs_to :user
  validate :stock_quantity_is_positive, :stock_quantity_scale_is_one

  enum transaction_type: %i[buy sell]

  scope :buy_list, -> { where(transaction_type: 0).desc_created_at }
  scope :sell_list, -> { where(transaction_type: 1).desc_created_at }
  scope :desc_created_at, -> { order(created_at: :desc) }

  def buy
    self.transaction_type = 0
    self.amount = quantity.to_i * unit_price
    self
  end

  def sell
    self.transaction_type = 1
    self.amount = quantity.to_i * unit_price
    self
  end

  private

  def stock_quantity_is_positive
    errors.add(:base, 'Please input valid number of shares') if quantity.to_i.zero?
    errors.add(:base, 'An input of negative share is not possible') if quantity.to_i.negative?
  end

  def stock_quantity_scale_is_one
    unless quantity.to_i == quantity.to_i.round(1)
      errors.add(:base, 'You can only input number of shares up to scale of 1 (e.g. 1, 2, 1.5, 2.5)')
    end
  end
end
