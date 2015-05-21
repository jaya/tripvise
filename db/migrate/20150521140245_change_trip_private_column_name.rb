class ChangeTripPrivateColumnName < ActiveRecord::Migration
  def change
    rename_column :trips, :private?, :hidden
  end
end
