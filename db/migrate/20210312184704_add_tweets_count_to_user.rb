class AddTweetsCountToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :tweets_count, :integer
  end
end
