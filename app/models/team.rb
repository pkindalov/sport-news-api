# frozen_string_literal: true

class Team < ApplicationRecord
  belongs_to :sport_category
  belongs_to :user

  validates :name, presence: true,
                   uniqueness: { scope: :sport_category_id, message: 'You already have a team with that name in this category' }
end
