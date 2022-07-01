class User < ApplicationRecord
  has_many :stocks, dependent: :destroy
  has_many :stock_transactions, dependent: :destroy
  has_many :balance_transactions, dependent: :destroy

  validates :balance, numericality: { greater_than_or_equal_to: 0 }

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
end
