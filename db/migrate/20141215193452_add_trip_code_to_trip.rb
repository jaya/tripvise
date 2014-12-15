class AddTripCodeToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :code, :string
  end
end
