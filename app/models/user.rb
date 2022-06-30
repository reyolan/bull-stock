class User < ApplicationRecord
  has_many :stocks, dependent: :destroy
  has_many :transactions, dependent: :destroy

  enum role: %i[admin trader]
  after_initialize :set_default_role, :if => :new_record?

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable

  private

  def set_default_role
    self.role ||= :trader
  end
end
