module Api
  module V1
    class TeamsController < ApplicationController
      before_action :authenticate_request!
      before_action :set_sport_category
      before_action :set_team, only: %i[update destroy news]

      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

      def create
        @team = @sport_category.teams.build(team_params)
        @team.user = @current_user

        if @team.save
          render json: { status: 'success', msg: 'Team created successfully', team: @team }, status: :created
        else
          render json: { status: 'error', msg: 'Failed to create team', errors: @team.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @team.update(team_params)
          render json: { status: 'success', msg: 'Team updated successfully', team: @team }, status: :ok
        else
          render json: { status: 'error', msg: 'Failed to update team', errors: @team.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @team.destroy
          render json: { status: 'success', msg: 'Team deleted successfully' }, status: :ok
        else
          render json: { status: 'error', msg: 'Failed to delete team', errors: @team.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def news
        news_articles = @team.news_articles
        render json: { status: 'success', news_articles: }, status: :ok
      end

      private

      def set_sport_category
        @sport_category = SportCategory.find(params[:sport_category_id])
      end

      def set_team
        @team = @sport_category.teams.find(params[:id])
      end

      def team_params
        params.require(:team).permit(:name, :short_description)
      end

      def record_not_found(error)
        render json: { status: 'error', msg: error.message }, status: :not_found
      end
    end
  end
end
