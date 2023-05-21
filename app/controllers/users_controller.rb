# frozen_string_literal: true

# UsersController
class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[create login]

  def index
    @users = User.all
    render json: @users, status: 200
  end

  def show
    @user = User.find(params[:id])
    if @user
      render json: @user, status: :ok
    else
      render json: { error: @user.errors.full_messages }, status: :not_found
    end
  end

  def create
    @user = User.new(params.require(:user).permit(:username, :email, :password))
    if @user.save
      # flash[:success] = 'User successfully created'
      render json: @user, status: 200
    else
      # flash[:error] = 'Something went wrong'
      render json: { error: @user.errors.full_messages }, status: 503
    end
  end

  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = jwt_encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token:, exp: time.strftime('%m-%d-%Y %H:%M'), username: @user.username }, status: 200
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end
end
