class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.integer :recommender_id
      t.integer :place_id
      t.integer :trip_id
      t.string :description
      t.boolean :wishlisted
      t.string :rating

      t.timestamps
    end
  end
end
