
class UserNotificationMailer < ApplicationMailer

  def missed_learning_event
    @user = params[:user]
    mail(to: @user.email, subject: 'Reminder of learning event!')
  end
end