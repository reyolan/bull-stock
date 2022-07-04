class UserMailer < ApplicationMailer
  def account_approval_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Bull Stock Account Approval')
  end
end
