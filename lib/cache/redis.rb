# frozen_string_literal: true

# Cache concern
module Cache
  def self.client
    @client ||= Redis.new
  end
end
