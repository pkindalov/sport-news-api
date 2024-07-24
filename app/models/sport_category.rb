# frozen_string_literal: true

class SportCategory < ApplicationRecord
  belongs_to :user
  has_many :teams, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user_id, message: 'You have already category with this name' }
end
