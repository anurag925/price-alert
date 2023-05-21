# frozen_string_literal: true

require 'jwt'

# jwt module
module JwtToken
  extend ActiveSupport::Concern

  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  # function to encode data to jwt
  def jwt_encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  # function to decode data from jwt
  def jwt_decode(token)
    JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(decoded_token)
  end
end
