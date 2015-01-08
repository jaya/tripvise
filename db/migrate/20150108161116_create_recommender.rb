class CreateRecommender < ActiveRecord::Migration
  def change
    create_table :recommenders do |recommender|
      recommender.integer :user_id
      recommender.integer :trip_id
      recommender.integer :code_id
    end
  end
end
