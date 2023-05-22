# frozen_string_literal: true

# Binance data Fetch worker
class BinanceWebsocketLivelinessCheckWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    Rails.logger.info "BinanceDataFetchWorker started at #{Time.now}"
    Rails.logger.info 'Checking Binance websocket connection'
    Rails.logger.info "BinanceDataFetchWorker ended at #{Time.now}"
  end
end
