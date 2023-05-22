# frozen_string_literal: true

# == Schema Information
#
# Table name: alerts
#
#  id         :bigint           not null, primary key
#  amount     :float
#  status     :integer          default("created")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_alerts_on_status_and_amount  (status,amount)
#  index_alerts_on_user_id            (user_id)
#
require 'test_helper'

class AlertTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
