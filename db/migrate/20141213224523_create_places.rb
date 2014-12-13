class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |place|
      place.string :name

      place.timestamps
    end
  end
end
