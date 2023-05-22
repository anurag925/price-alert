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
    user_alerts
    filter_alerts_for_status
    paginated_user_alerts
    render json: @user_alerts, status: :ok
  end

  private

  def user_alerts
    @user_alerts ||= @current_user.alerts.all
  end

  def filter_alerts_for_status
    @user_alerts = user_alerts.where(status: params[:status]) if params[:status]
  end

  def paginated_user_alerts
    page_items = 1
    @user_alerts = user_alerts.offset(page_items * (page_no - 1)).limit(page_items) if page_no
  end

  def page_no
    int(params[:page])
  end
end
