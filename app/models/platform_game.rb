class PlatformGame < ActiveRecord::Base
  belongs_to :platform
  belongs_to :game
end
