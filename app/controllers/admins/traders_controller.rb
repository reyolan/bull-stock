# Admin User Story #1 - #4
class Admins::TradersController < ApplicationController
  def index
    # User Story #4
    if current_user.admin?
      @traders = User.where "role = ?", 0
    else 
      redirect_to root_path
    end
  end

  def show
    # User Story #3
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
  end

  def update
    # User Story #2
  end

  def destroy; end


  private

  def trader_params
    params.require(:user).permit(:email,:password,:password_confirmation)
  end


end
