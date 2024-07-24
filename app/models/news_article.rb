# frozen_string_literal: true

class NewsArticle < ApplicationRecord
  belongs_to :team
  belongs_to :user

  validates :title, presence: true, length: { minimum: 5, maximum: 200 }
  validates :text, presence: true, length: { minimum: 5, maximum: 1000 }
  validates :source, presence: true, length: { minimum: 5, maximum: 100 }
  validates :published_at, presence: true
end
