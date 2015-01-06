class IncreaseStringSizeOnToken < ActiveRecord::Migration
  def change
    change_column :users, :fb_token, :string, limit: 256
  end
end
