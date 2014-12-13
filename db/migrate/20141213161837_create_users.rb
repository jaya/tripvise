class CreausereUsers < ActiveRecord::Migration
  def change
    create_table :users do |user|
      user.string :name
      user.string :fb_id
      user.string :fb_token
      user.string :email

      user.timestamps
    end
  end
end
