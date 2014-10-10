class Platform < ActiveRecord::Base
  has_many :platform_users
  has_many :users,      :through => :platforms
end
