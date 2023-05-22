# frozen_string_literal: true

# alert mailers
class AlertMailer < ApplicationMailer
  def alert_triggered(user, amount)
    @user = user
    @amount = amount

    mail(to: @user.email, subject: 'Alert triggered')
  end
end
