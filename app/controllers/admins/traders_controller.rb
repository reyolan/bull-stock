# Admin User Story #1 - #4
class Admins::TradersController < ApplicationController
  before_action :authenticate_admin

  def index
    # User Story #4
      @traders = User.where "role = ?", 0
  end

  def show
    # User Story #3
    @trader = User.find params[:id]
  end

  def new
    @trader = User.new
    # User Story #1
  end

  def create
    # User Story #1
    @trader = User.create trader_params
      respond_to do |format|
        if  @trader.save
            format.html { redirect_to traders_path, notice: "Trader was successfully created!" }
        else
            format.html { render :new, status: :unprocessable_entity }
        end
      end
  end

  def edit
    # User Story #2
    @trader = User.find params[:id]
  end

  def update
    # User Story #2
    @trader = User.find params[:id]
    respond_to do |format|
      if @trader.update(trader_update_params)
        format.html { redirect_to traders_path(@trader), notice: "Trader details was successfully updated!" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def trader_params
    params.require(:user).permit(:email,:password,:password_confirmation)
  end

  def trader_update_params
    params.require(:user).permit(:email,:approved)
  end
end
