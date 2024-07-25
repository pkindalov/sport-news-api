# frozen_string_literal: true

module SportCategoriesHelper
  def sport_category_with_avatar(sport_category)
    {
      id: sport_category.id,
      name: sport_category.name,
      created_at: sport_category.created_at,
      updated_at: sport_category.updated_at,
      avatar_url: sport_category.avatar.attached? ? url_for(sport_category.avatar) : nil
    }
  end

  def sport_categories_with_avatars(sport_categories)
    sport_categories.map { |sport_category| sport_category_with_avatar(sport_category) }
  end
end
