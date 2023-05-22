# frozen_string_literal: true

# Binance data Fetch worker
class BinanceDataUpdateWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(opening_price, closing_price)
    Rails.logger.info "BinanceDataFetchWorker started at #{Time.now}"
    Rails.logger.info "Opening price: #{opening_price}, Closing price #{closing_price}"
    created_alerts = Alert.where(status: 'created').where(
      '(amount >= ? and amount <= ?) or (amount >= ? and amount <= ?)', opening_price.to_f, closing_price.to_f, closing_price.to_f, opening_price.to_f
    )
    if created_alerts.present? && created_alerts.update_all(status: 'triggered')
      AlertTriggeredMailWorker.perform_async(created_alerts.pluck(:user_id, :amount).uniq)
    end
    Rails.logger.info "BinanceDataFetchWorker ended at #{Time.now}"
  end
end
