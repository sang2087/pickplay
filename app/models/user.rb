class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :comments
  has_many :wishes
  has_many :platform_users
  has_many :platforms, :through => :platform_users
  has_many :ratings
  has_one :user_stat
  after_create :make_platform_user

  def make_platform_user
    Platform.all.ids.each do |platform_id|
      PlatformUser.create(platform_id: platform_id, user_id: self.id)
    end
  end

  def set_stat
    user_stat = self.user_stat
    if user_stat.nil?
      user_stat = UserStat.new
      user_stat.user_id = self.id
    end

    stat = Array.new
    total = Array.new

    0.upto(4).each do |i|
      stat[i] = 0
      total[i] = 0
    end
    ratings = self.ratings
    ratings.each do |rating|
      game_stat = rating.game.game_stat
      0.upto(4).each do |i|
        stat[i] += game_stat.send("stat#{i}") * rating.score
        total[i] += rating.score
      end
    end

    user_stat.stat0 = stat[0].to_f/total[0]
    user_stat.stat1 = stat[1].to_f/total[1]
    user_stat.stat2 = stat[2].to_f/total[2]
    user_stat.stat3 = stat[3].to_f/total[3]
    user_stat.stat4 = stat[4].to_f/total[4]
    user_stat.save
  end

  def get_order_by_sd games
    arr = Array.new
    user_stat = self.user_stat
    game_stats = Array.new
    genre_rating = Array.new

    self.ratings.each do |rating|
      rating.game.genre_ids.split("/").each do |genre_id|
        if genre_rating[genre_id.to_i].nil?
          genre_rating[genre_id.to_i] = 0
        end
        genre_rating[genre_id.to_i] += rating.score
      end
    end

    games.each do |game|
      game_stats.push(game.game_stat)
      game.genre_ids.split("/")
    end

    total_sd = 0
    total_gs = 0

    game_stats.each do |game_stat|
      var = 0
      0.upto(4) do |i|
        var += (game_stat.send("stat#{i}") - user_stat.send("stat#{i}")) ** 2
      end
      sd = var ** 0.5
      total_sd += sd
      game = game_stat.game
      genre_score = 0
      game.genre_ids.split("/").each do |genre_id|
        unless genre_rating[genre_id.to_i].nil?
          genre_score += genre_rating[genre_id.to_i]
        end
      end
      total_gs += genre_score;
      total_sd += sd;

      arr.push({game:game,
                sd:sd,
                gs:genre_score
      })
    end
    arr.each do |a|
      a[:ratio_sd] = a[:sd] * (total_gs/total_sd)
      a[:ret] =  a[:ratio_sd] + a[:gs]
    end

    arr.sort_by!{|x| x[:ret]}
    arr.reverse!

    stand = arr[0][:ret].to_f
    arr.each do |a|
      a[:ret] = (a[:ret].to_f / stand * 5.0)
      a[:ret] ='%.1f' %  a[:ret]
    end

    arr
  end
end
