class AddRecommendationTypeIdToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :recommendation_type_id, :integer
  end
end
