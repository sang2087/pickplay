class PlatformUser < ActiveRecord::Base
  belongs_to :platform
  belongs_to :user
end
