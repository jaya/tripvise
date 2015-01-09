class CreateCodeTable < ActiveRecord::Migration
  def change
    create_table :codes do |code|
      code.string :code
      code.datetime :expiration_date
      code.integer :trip_id
    end
  end
end
