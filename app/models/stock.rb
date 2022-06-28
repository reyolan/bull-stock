class Stock < ApplicationRecord
  belongs_to :user
  validates :quantity, numericality: { greater_than: 0 }

  # soft delete the stock
  # use Discard gem

  def subtract_share(sold_stock_params)
    subtracted_quantity = quantity - sold_stock_params[:quantity]
    if subtracted_quantity.zero?
      destroy
    else
      amount = total_amount(quantity: sold_stock_params[:quantity], unit_price:)
      quantity = subtract_quantity(sold_stock_params[:quantity])
      update(quantity:, amount:)
    end
  end

  def add_share(bought_stock_params)
    # for update only
    debugger
    quantity = add_quantity(bought_stock_params[:quantity])
    unit_price = average_price_per_share(new_quantity: bought_stock_params[:quantity],
                                         new_price_per_share: bought_stock_params[:unit_price])
    amount = total_amount(quantity: bought_stock_params[:quantity], unit_price: bought_stock_params[:unit_price])
    update(quantity:, unit_price:, amount:)
  end

  private

  def add_quantity(bought_quantity)
    quantity + bought_quantity
  end

  def subtract_quantity(sold_quantity)
    quantity - sold_quantity
  end

  def total_amount(quantity:, unit_price:)
    quantity * unit_price
  end

  def average_price_per_share(new_quantity:, new_price_per_share:)
    # get the existing price per share, multiply it with the existing number of shares
    # then add the newly bought share (number of share * price per share)
    old_price_per_share = unit_price
    old_quantity = quantity
    ((old_price_per_share * old_quantity) + (new_price_per_share * new_quantity)) / new_quantity
  end
end
