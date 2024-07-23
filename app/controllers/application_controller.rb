# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_request!

  private

  def authenticate_request!
    token = request.headers['Authorization']&.split(' ')&.last

    if token.present?
      begin
        decoded_token = JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256')
        user_id = decoded_token.first['user_id']
        @current_user = User.find(user_id) if user_id
      rescue JWT::DecodeError
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    else
      render json: { error: 'Missing token' }, status: :unauthorized
    end
  end
end
