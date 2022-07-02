class UserMailer < ApplicationMailer
    def account_approval_email
        @user = params[:user]
        @url  = 'http://example.com/login' #change this after deploying to heroku
        mail(to: @user.email, subject: 'Bull Stock Account Approval')
    end
end
