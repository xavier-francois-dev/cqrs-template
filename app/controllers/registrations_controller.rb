# frozen_string_literal: true

class RegistrationsController < ApplicationController
  def create
    user= User.new(user_params)
    if user.save
      render json: { user: { id: user.id, email: user.email } }, status: :created
    else
      render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.fetch(:user, {}).permit(:email, :password, :password_confirmation)
  end
end
