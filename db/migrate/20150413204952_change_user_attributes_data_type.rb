class ChangeUserAttributesDataType < ActiveRecord::Migration
  def change
    change_column :users, :fb_token, :text, limit: nil
    change_column :users, :fb_id, :text
  end
end
