class Stock < ApplicationRecord
  belongs_to :user
  validate :quantity_is_positive_or_zero

  before_save :total_amount
  after_save :destroy_stock_if_zero_quantity

  # soft delete the stock
  # use Discard gem
  scope :overall_amount, -> { sum(:amount) }
  scope :overall_shares, -> { sum(:quantity) }
  scope :asc_symbol, -> { order(:symbol) }

  def buy_share(bought_stock)
    params_bought_quantity = bought_stock[:quantity].to_d
    params_unit_price = bought_stock[:unit_price].to_d
    self.unit_price = average_price_per_share(new_quantity: params_bought_quantity,
                                              new_price_per_share: params_unit_price)
    self.quantity = add_quantity(params_bought_quantity)
    self
  end

  def sell_share(sold_stock)
    params_sold_quantity = sold_stock[:quantity].to_d
    self.quantity = subtract_quantity(params_sold_quantity)
    self
  end

  private

  def quantity_is_positive_or_zero
    errors.add(:base, 'Insufficient number of shares to sell') if quantity.negative?
  end

  def destroy_stock_if_zero_quantity
    destroy if quantity.zero?
  end

  def total_amount
    self.amount = quantity * unit_price
  end

  def average_price_per_share(new_quantity:, new_price_per_share:)
    old_price_per_share = unit_price
    old_quantity = quantity
    total_quantity = old_quantity + new_quantity
    ((old_price_per_share * old_quantity) + (new_price_per_share * new_quantity)) / total_quantity
  end

  def add_quantity(bought_quantity)
    quantity + bought_quantity
  end

  def subtract_quantity(sold_quantity)
    quantity - sold_quantity
  end
end
