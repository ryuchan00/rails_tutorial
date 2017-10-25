class AddNotifyAddFollowerToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :notify_add_follower, :boolean, default: false
  end
end
