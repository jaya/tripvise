class UpdateTripsPrivateRegisters < ActiveRecord::Migration
  def up
    Trip.update_all(private?: true)
  end

  def down
    Trip.update_all(private?: false)
  end
end
