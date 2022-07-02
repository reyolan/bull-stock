class User < ApplicationRecord
  has_many :stocks, dependent: :destroy
  has_many :stock_transactions, dependent: :destroy
  has_many :balance_transactions, dependent: :destroy

  validate :balance_is_positive_or_zero

  enum role: %i[admin trader]
  after_initialize :set_default_role, :if => :new_record?

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable

  scope :traders, -> { where(role: '1') }

  def save_trader
    self.approved = true
    save
  end

  def add_amount(amount_to_add)
    self.balance += amount_to_add
    self
  end

  def subtract_amount(amount_to_subtract)
    self.balance -= amount_to_subtract
    self
  end

  private

  def set_default_role
    self.role ||= :trader
  end

  def balance_is_positive_or_zero
    errors.add(:base, 'Insufficient balance for the input you entered.') if balance.negative?
  end
end
