class User < ApplicationRecord
  has_many :stocks, dependent: :destroy
  has_many :transactions, dependent: :destroy
  validates :balance, numericality: { greater_than: 0 }

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

  private

  def set_default_role
    self.role ||= :trader
  end
end
