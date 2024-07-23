class SportCategory < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, uniqueness: { scope: :user_id, message: 'You have already category with this name' }
end
