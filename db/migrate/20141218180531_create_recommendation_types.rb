class CreateRecommendationTypes < ActiveRecord::Migration
  def change
    create_table :recommendation_types do |recommendation_type|
      recommendation_type.boolean :hotels
      recommendation_type.boolean :attractions
      recommendation_type.boolean :restaurants
    end
  end
end
