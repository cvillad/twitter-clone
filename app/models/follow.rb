class Follow < ApplicationRecord
  # The user giving the follow
  belongs_to :follower, foreign_key: :follower_id, class_name: "User", counter_cache: :followings_count

  # The user being followed
  belongs_to :followed_user, foreign_key: :followed_user_id, class_name: "User", counter_cache: :followers_count
end
