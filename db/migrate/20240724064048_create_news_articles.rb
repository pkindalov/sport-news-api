class CreateNewsArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :news_articles do |t|
      t.string :title
      t.text :text
      t.string :source
      t.datetime :published_at
      t.references :team, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
