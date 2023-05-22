# frozen_string_literal: true

# AlertsController
class AlertsController < ApplicationController
  def index
    @alerts = Alert.all
    render json: @alerts, status: :ok
  end

  def show
    @alert = Alert.find(params[:id])
    if @alert
      render json: @alert, status: :ok
    else
      render json: { error: @alert.errors.full_messages }, status: :not_found
    end
  end

  def create
    @alert = Alert.new(params.require(:alert).permit(:amount))
    @alert.user = @current_user
    if @alert.save
      client.del("alerts_#{@current_user.id}")
      render json: @alert, status: :ok
    else
      render json: { error: @alert.errors.full_messages }, status: 503
    end
  end

  def destroy
    @alert = Alert.find(params[:id])
    if @alert&.destroy
      render json: @alert, status: :ok
    else
      render json: { error: @alert.errors.full_messages }, status: :not_found
    end
  end

  def user_alert
    all_user_alerts
    user_alert_conditions
    render json: user_alerts, status: :ok
  end

  private

  def user_alerts
    @user_alerts ||= @current_user.alerts
  end

  def all_user_alerts
    return if params[:status] || params[:page]

    alerts = client.get("alerts_#{@current_user.id}")
    if alerts
      @user_alerts = alerts
      return
    end
    client.set("alerts_#{@current_user.id}", user_alerts.to_json)
  end

  def user_alert_conditions
    @user_alerts = user_alerts.where(status: params[:status]) if params[:status]
    @user_alerts = user_alerts.offset(page_no * page_items).limit(page_items) if params[:page]
  end

  def page_no
    (params[:page] || 1).to_i - 1
  end

  def page_items
    100
  end
end
