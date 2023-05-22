# frozen_string_literal: true

module Cache
  def self.client
    @client ||= Redis.new
  end
end
