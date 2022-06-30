# Admin User Story # 7
class Admins::TransactionsController < ApplicationController
  before_action :authenticate_admin

  def index
    # User Story #7
    # @transactions = Transaction.all
  end
end
