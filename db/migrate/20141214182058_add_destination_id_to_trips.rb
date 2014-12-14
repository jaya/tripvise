class AddDestinationIdToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :destination_id, :integer
  end
end
