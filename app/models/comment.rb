class Comment < ActiveRecord::Base
  belongs_to :game
  belongs_to :user

  def rate
    score = Rating.where(game_id: self.game_id, user_id: self.user_id).first.score

    score
  end
end
