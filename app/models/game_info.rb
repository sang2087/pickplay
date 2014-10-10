class GameInfo < ActiveRecord::Base
  has_attached_file :image, :styles => { :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  belongs_to :game
  def get_data
    game_info = self.attributes
    game_info["genre_name"] = self.game.genre_names
    game_info["platform_name"] = self.game.platform_names
    game_info["image_url"] = self.image.url(:original)
    game_info
  end
end
