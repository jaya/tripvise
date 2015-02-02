class AddPlaceTypeToRecommendation < ActiveRecord::Migration
  def change
    add_column :recommendations, :place_type, :string
  end
end
