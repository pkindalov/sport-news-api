# app/controllers/api/v1/sport_categories_controller.rb
module Api
  module V1
    class SportCategoriesController < ApplicationController
      before_action :authenticate_request!
      before_action :set_sport_category, only: [:show, :update, :destroy]

      def index
        @sport_categories = @current_user.sport_categories
        render json: { status: 'success', msg: 'Спортните категории са успешно извлечени', data: @sport_categories }
      end

      def show
        render json: { status: 'success', msg: 'Спортната категория е успешно извлечена', data: @sport_category }
      end

      def create
        @sport_category = @current_user.sport_categories.build(sport_category_params)
        if @sport_category.save
          render json: { status: 'success', msg: 'Спортната категория е успешно създадена', data: @sport_category }, status: :created
        else
          render json: { status: 'error', msg: @sport_category.errors.full_messages.join(', ') }, status: :unprocessable_entity
        end
      end

      def update
        if @sport_category.update(sport_category_params)
          render json: { status: 'success', msg: 'Спортната категория е успешно актуализирана', data: @sport_category }
        else
          render json: { status: 'error', msg: @sport_category.errors.full_messages.join(', ') }, status: :unprocessable_entity
        end
      end

      def destroy
        @sport_category.destroy
        render json: { status: 'success', msg: 'Спортната категория е успешно изтрита' }
      end

      private

      def set_sport_category
        @sport_category = @current_user.sport_categories.find(params[:id])
      end

      def sport_category_params
        params.require(:sport_category).permit(:name)
      end
    end
  end
end
