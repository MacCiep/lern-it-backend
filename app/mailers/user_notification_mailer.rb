# frozen_string_literal: true

class UserNotificationMailer < ApplicationMailer
  def missed_learning_event
    @user = params[:user]
    mail(to: @user.email, subject: t('user_notification_mailer.missed_learning_event.subject'))
  end
end
