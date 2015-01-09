class RemoveCodeFromTrip < ActiveRecord::Migration
  def change
    remove_column :trips, :code
  end
end
