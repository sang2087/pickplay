class UserPlatform < ActiveRecord::Base
  belongs_to :user
  belongs_to :platform
end
