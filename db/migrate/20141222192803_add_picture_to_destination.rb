class AddPictureToDestination < ActiveRecord::Migration
  def change
    add_column :destinations, :picture, :string, default: nil
  end
end
