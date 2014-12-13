class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |destination|
      destination.string :city
      destination.string :state
      destination.string :country
      destination.string :full_qualified_name

      destination.timestamps
    end
  end
end
