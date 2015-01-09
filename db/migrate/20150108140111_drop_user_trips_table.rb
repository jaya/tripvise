class DropUserTripsTable < ActiveRecord::Migration
  def change
    drop_table :table_users_trips
    drop_table :user_trips
  end
end
