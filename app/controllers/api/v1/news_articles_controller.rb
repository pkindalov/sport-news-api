# frozen_string_literal: true

module Api
  module V1
    class NewsArticlesController < ApplicationController
      before_action :authenticate_request!
      before_action :set_team
      before_action :set_news_article, only: %i[show update destroy]

      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

      def create
        @news_article = @team.news_articles.build(news_article_params)
        @news_article.user = @current_user
        if @news_article.save
          render json: { status: 'success', msg: 'News article created successfully', news_article: @news_article }, status: :created
        else
          render json: { status: 'error', msg: 'Failed to update news article', errors: @news_article.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def show
        render json: { status: 'success', news_article: @news_article }, status: :ok
      end

      def index
        pagy, news_articles = pagy(@team.news_articles)
        render json: { status: 'success', data: news_articles, pagination: pagy_metadata(pagy) }, status: :ok
      end

      def update
        if @news_article.update(news_article_params)
          render json: { status: 'success', msg: 'News article updated successfully', news_article: @news_article }, status: :ok
        else
          render json: { status: 'error', msg: 'Failed to update news article', errors: @news_article.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @news_article.destroy
          render json: { status: 'success', msg: 'News article deleted successfully' }, status: :ok
        else
          render json: { status: 'error', msg: 'Failed to delete news article', errors: @news_article.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_team
        @team = Team.find(params[:team_id])
      end

      def set_news_article
        @news_article = @team.news_articles.find(params[:id])
      end

      def news_article_params
        params.require(:news_article).permit(:title, :text, :source, :published_at)
      end

      def record_not_found(error)
        render json: { status: 'error', msg: error.message }, status: :not_found
      end

    end
  end
end
