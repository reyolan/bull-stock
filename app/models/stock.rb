class Stock < ApplicationRecord
  belongs_to :user
  validates :quantity, numericality: { greater_than: 0 }
  before_create :total_amount

  # soft delete the stock
  # use Discard gem

  def sell_share!(sold_stock)
    params_sold_quantity = sold_stock[:quantity].to_d
    params_unit_price = sold_stock[:unit_price].to_d
    subtracted_quantity = quantity - params_sold_quantity
    if subtracted_quantity.zero?
      destroy
    else
      quantity = subtract_quantity(params_sold_quantity)
      amount = new_total_amount(quantity:, unit_price: params_unit_price)
      update!(quantity:, amount:)
    end
  end

  def buy_share!(bought_stock)
    params_bought_quantity = bought_stock[:quantity].to_d
    params_unit_price = bought_stock[:unit_price].to_d
    quantity = add_quantity(params_bought_quantity)
    unit_price = average_price_per_share(new_quantity: params_bought_quantity,
                                         new_price_per_share: params_unit_price,
                                         total_quantity: quantity)
    amount = new_total_amount(quantity:, unit_price: params_unit_price)
    update!(quantity:, unit_price:, amount:)
  end

  private

  def add_quantity(bought_quantity)
    quantity + bought_quantity
  end

  def subtract_quantity(sold_quantity)
    quantity - sold_quantity
  end

  def new_total_amount(quantity:, unit_price:)
    quantity * unit_price
  end

  def total_amount
    self.amount = quantity * unit_price
  end

  def average_price_per_share(new_quantity:, new_price_per_share:, total_quantity:)
    old_price_per_share = unit_price
    old_quantity = quantity
    ((old_price_per_share * old_quantity) + (new_price_per_share * new_quantity)) / total_quantity
  end
end
