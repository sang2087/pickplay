class Game < ActiveRecord::Base
  has_attached_file :image, :styles => { :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  has_one :game_info
  has_many :comments
  has_many :rating

  def genre_names
    genres = self.genre_ids.split("/")
    names = Array.new
    genres.each do |genre|
      names.push(Genre.find(genre).name)
    end

    names.join(", ")
  end

  def platform_names
    platforms = self.platform_ids.split("/")
    names = Array.new
    platforms.each do |platform|
      names.push(Platform.find(platform).name)
    end

    names.join(", ")
  end

  def get_comment_data
    comments = self.comments
    ret = Array.new
    comments.each do |comment|
      c = comment.attributes
      c["email"] = comment.user.email
      c["score"] = comment.rate
      ret.push(c)
    end
    ret
  end

  def set_rate score, user_id
    rating = Rating.where(game_id: self.id, user_id: user_id).first
    if rating.nil?
      rating = Rating.new
      rating.game_id = self.id
      rating.user_id = user_id
    end
    rating.score = score
    rating.save
  end

  def rate user_id
    rating = Rating.where(game_id: self.id, user_id: user_id).first
    score = 0
    unless rating.nil?
      score = rating.score
    end
    score
  end
end
