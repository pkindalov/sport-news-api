module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_request!
      include Rails.application.routes.url_helpers

      def update
        if @current_user.update(user_params)
          if params[:user][:avatar]
            @current_user.avatar.attach(params[:user][:avatar])
          end
          render json: {
            message: 'Profile updated successfully',
            user: user_response(@current_user)
          }, status: :ok
        else
          render json: { errors: @current_user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @current_user.destroy
          @current_user.avatar.purge if @current_user.avatar.attached?
          render json: { message: 'Profile deleted successfully' }, status: :ok
        else
          render json: { errors: @current_user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy_avatar
        if @current_user.avatar.attached?
          @current_user.avatar.purge
          render json: { message: 'Avatar deleted successfully' }, status: :ok
        else
          render json: { errors: ['No avatar to delete'] }, status: :unprocessable_entity
        end
      end

      def list
        users = User.select(:id, :email, :created_at, :updated_at)
        render json: { users: }, status: :ok
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :avatar)
      end

      def user_response(user)
        {
          id: user.id,
          email: user.email,
          avatar_url: avatar_url(user)
        }
      end

      def avatar_url(user)
        user.avatar.attached? ? url_for(user.avatar) : nil
      end
    end
  end
end
