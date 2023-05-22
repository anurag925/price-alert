# frozen_string_literal: true

# Binance data Fetch worker
class AlertTriggeredMailWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(triggered_alerts)
    triggered_alerts.each do |triggered_alert|
      user = User.find(triggered_alert[0])
      amount = triggered_alert[1]
      AlertsMailer.alert_triggered(user, amount).deliver_later
    end
  end
end
