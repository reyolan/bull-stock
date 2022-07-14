class UserMailer < ApplicationMailer
  def account_approval_email
    @user = params[:user]
    mail(to: @user.email, subject: "Bull Stock Account Approval")
  end

  def account_deletion_email
    @user_email = params[:user]
    mail(to: @user_email, subject: "Bull Stock Account Deletion")
  end
end
