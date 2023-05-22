# rubocop:disable Metrics/BlockLength
# frozen_string_literal: true

require 'websocket-client-simple'
require "#{Rails.root}/app/workers/binance_data_update_worker.rb"

namespace :binance_price_fetch do
  task :start do
    Rails.logger = Logger.new(Rails.root.join('log', 'binance_price_fetch.log'))

    if ENV['BACKGROUND']
      # run in background
      Process.daemon(true, true)
    end

    File.open(ENV['PIDFILE'], 'w') { |f| f.write(Process.pid) } if ENV['PIDFILE']
    Signal.trap('TERM') { abort }
    Signal.trap('INT') { abort }
    begin
      Rails.logger.info 'Starting binance price fetch'
      ws = WebSocket::Client::Simple.connect 'wss://stream.binance.com:9443/ws/btcusdt@miniTicker'
      ws.on :open do
        Rails.logger.info 'Binance price fetch connected'
      end
      ws.on :message do |msg|
        Rails.logger.info "Binance price fetch msg #{msg}"
        msg = JSON.parse(msg.data)
        BinanceDataUpdateWorker.perform_async(msg['o'], msg['c'])
      end
      ws.on :close do |e|
        Rails.logger.info "closed wss with binance price fetch #{e.message}"
        exit 1
      end
      ws.on :error do |e|
        Rails.logger.error "error with binance price fetch #{e.message}"
      end
      loop do
        ws.send $stdin.gets.strip
      end
      Rails.logger.info 'Starting binance price fetch done'
    rescue StandardError => e
      Rails.logger.error "error with binance price fetch #{e.message}"
    end
  end
end

# rubocop:enable Metrics/BlockLength
