class Stock < ApplicationRecord
  belongs_to :user
  validates :quantity, numericality: { greater_than: 0 }
  before_create :total_amount

  # soft delete the stock
  # use Discard gem

  def subtract_share(sold_stock_params)
    subtracted_quantity = quantity - sold_stock_params[:quantity]
    if subtracted_quantity.zero?
      destroy
    else
      amount = new_total_amount(quantity: sold_stock_params[:quantity], unit_price:)
      quantity = subtract_quantity(sold_stock_params[:quantity])
      update(quantity:, amount:)
    end
  end

  def add_share(bought_stock_params)
    params_bought_quantity = bought_stock_params[:quantity].to_d
    params_unit_price = bought_stock_params[:unit_price].to_d
    quantity = add_quantity(params_bought_quantity)
    unit_price = average_price_per_share(new_quantity: params_bought_quantity,
                                         new_price_per_share: params_unit_price,
                                         total_quantity: quantity)
    amount = new_total_amount(quantity:, unit_price: params_unit_price)
    update(quantity:, unit_price:, amount:)
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
