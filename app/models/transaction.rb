class Transaction < ApplicationRecord
  belongs_to :user

  enum transaction_type: %i[buy sell]
end
