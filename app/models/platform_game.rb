class PlatformGame < ActiveRecord::Base
  belongs_to :platform
  belongs_to :game
  def self.set_platform_from_seed seed, game_id
    seed.split(",")
    platform_ids = Array.new
    Platform.all.each do |platform|
      if seed.include? platform.name
        platform_ids.push(platform.id)
      end
    end
    platform_ids.each do |platform_id|
      PlatformGame.create(game_id: game_id, platform_id: platform_id)
    end
  end

end
