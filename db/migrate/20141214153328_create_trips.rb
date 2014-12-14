class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |trip|
      trip.datetime :start
      trip.datetime :end

      trip.timestamps
    end
  end
end
