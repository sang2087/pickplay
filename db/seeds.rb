# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Platform.create(name:"Windows")
Platform.create(name:"Mac")
Platform.create(name:"iOS")
Platform.create(name:"Android")
Platform.create(name:"PS3")
Platform.create(name:"PS4")
Platform.create(name:"WII")
Platform.create(name:"XBOX 360")
Platform.create(name:"XBOX ONE")
Platform.create(name:"PSP")
Platform.create(name:"3DS")

Genre.create(name:"인디")
Genre.create(name:"어드벤처")
Genre.create(name:"공포")
Genre.create(name:"액션")
Genre.create(name:"롤플레잉")
Genre.create(name:"코미디")



doc = File.open("#{Rails.root}/seed/PC-independent.tsv").readlines
counter = 0
doc.each do |line|
  counter+=1
  column = line.split("\t")
  seed = Hash.new
  seed[:genre] = column[0]
  seed[:name] = column[1]
  seed[:maker] = column[2]
  seed[:distribute] = column[3]
  seed[:date] = column[4]
  seed[:user_class] = column[5]
  seed[:content] = column[9]
  seed[:movie] = column[6]
  seed[:platform] = column[7]
  seed[:small_image] = "independent/#{counter+1}-1.jpg"
  seed[:big_image] = "independent/#{counter+1}-2.jpg"
  seed[:image] = column[7]

  Game.data_from_seed seed
end
#
#
# game = Game.create(name: '스타크래프트', image: File.open("#{Rails.root}/seed_image/thumb/starcraft.jpg"), genre_ids: "1/2")
# PlatformGame.create(game_id:game.id, platform_id: 1)
# PlatformGame.create(game_id:game.id, platform_id: 2)
# GameInfo.create(game_id: game.id, image: File.open("#{Rails.root}/seed_image/big/starcraft.jpg"), maker: "블리자드", distribute:"손오공", date:"1996.6.5", user_class:"12", content: "스타 짱!")
# GameMovie.create(game_id: game.id, movie_url: "//www.youtube.com/embed/28MeoIRFtUw")
