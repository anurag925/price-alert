# frozen_string_literal: true

class AlertMailerPreview < ActionMailer::Preview
  def alert_triggered
    AlertMailer.alert_triggered(User.first, 10_000)
  end
end
