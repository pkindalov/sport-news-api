module Api
  module V1
    class SportCategoriesController < ApplicationController
      before_action :authenticate_request!
      before_action :set_sport_category, only: %i[show update destroy]

      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

      def create
        @sport_category = @current_user.sport_categories.build(sport_category_params)

        if @sport_category.save
          render json: { status: 'success', msg: 'Sport category created successfully', sport_category: @sport_category }, status: :created
        else
          render json: { status: 'error', msg: 'Failed to create sport category', errors: @sport_category.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def index
        pagy, sport_categories = pagy(@current_user.sport_categories)
        render json: { status: 'success', sport_categories:, pagination: pagy_metadata(pagy) }, status: :ok
      end

      def all_users_categories
        pagy, all_users_categories = pagy(SportCategory.all)
        render json: { status: 'success', all_users_categories:, pagination: pagy_metadata(pagy) }, status: :ok
      end

      def show
        render json: { status: 'success', sport_category: @sport_category }, status: :ok
      end

      def update
        if @sport_category.update(sport_category_params)
          render json: { status: 'success', msg: 'Sport category updated successfully', sport_category: @sport_category }, status: :ok
        else
          render json: { status: 'error', msg: 'Failed to update sport category', errors: @sport_category.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @sport_category.destroy
          render json: { status: 'success', msg: 'Sport category deleted successfully' }, status: :ok
        else
          render json: { status: 'error', msg: 'Failed to delete sport category', errors: @sport_category.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_sport_category
        @sport_category = @current_user.sport_categories.find(params[:id])
      end

      def sport_category_params
        params.require(:sport_category).permit(:name)
      end

      def record_not_found(error)
        render json: { status: 'error', msg: error.message }, status: :not_found
      end
    end
  end
end
