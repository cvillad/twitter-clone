class AddFollowsCountToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :followings_count, :integer
    add_column :users, :followers_count, :integer
  end
end
