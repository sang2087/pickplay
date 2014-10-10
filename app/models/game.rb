class Game < ActiveRecord::Base
  has_attached_file :image, :styles => { :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  has_one :game_info
  has_many :comments
  has_many :ratings
  has_many :wishes
  has_many :game_movies
  has_many :platform_games
  has_many :platforms, :through => :platform_games

  def genre_names
    genres = self.genre_ids.split("/")
    names = Array.new
    genres.each do |genre|
      names.push(Genre.find(genre).name)
    end

    names.join(", ")
  end

  def platform_names
    names = Array.new
    self.platforms.each do |platform|
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

  def wish? user_id
    wish = Wish.where(game_id:self.id, user_id: user_id).first
    !wish.nil?
  end

  def self.get_platform_game user
    platform_ids = user.platform_ids
    platform_games = PlatformGame.where(:platform_id => platform_ids )
    games = Array.new
    platform_games.each do |p_g|
      games.push(p_g.game)
    end
    games
  end
  def self.data_from_seed seed
    game = Game.new
    #장르
    game.genre_ids = Genre.set_genre_from_seed(seed[:genre])
    game.image = File.open("#{Rails.root}/seed/image/small/#{seed[:small_image]}")
    #게임 이름
    game.name = seed[:name]
    game.save
    #제작사
    game_info = GameInfo.new
    game_info.game_id = game.id

    game_info.maker = seed[:maker]

    game_info.image = File.open("#{Rails.root}/seed/image/big/#{seed[:big_image]}")
    #유통사
    game_info.distribute = seed[:distribute]
    #출시날짜
    game_info.date = seed[:date]
    #이용등급
    game_info.user_class = seed[:user_class]
    #소개
    game_info.content = seed[:content]
    game_info.save
    #소개영상링크
    GameMovie.create(game_id: game.id, movie_url: seed[:movie])
    PlatformGame.set_platform_from_seed(seed[:platform], game.id)

    
  end
end
