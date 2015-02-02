class AddGooglePlacesUrlToRecommendation < ActiveRecord::Migration
  def change
    add_column :recommendations, :google_places_url, :string
  end
end
