# frozen_string_literal: true

module Cache
  def client
    @client ||= Redis.new
  end
end
