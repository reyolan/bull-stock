class User < ApplicationRecord
  has_many :stocks
  has_many :transactions

  enum role: %i[trader admin]
  after_initialize :set_default_role, :if => :new_record?

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable

  private

  def set_default_role
    self.role ||= :trader
  end
end
