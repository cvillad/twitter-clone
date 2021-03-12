class ResetAllUserCacheCounters < ActiveRecord::Migration[6.1]
  def up
    User.all.each do |user|
      User.reset_counters(user.id, :tweets)
    end
  end
end
