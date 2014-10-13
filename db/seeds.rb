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

Genre.create(name:"액션")
Genre.create(name:"스포츠")
Genre.create(name:"TPS")
Genre.create(name:"어드벤처")
Genre.create(name:"FPS")
Genre.create(name:"레이싱")
Genre.create(name:"RPG")
Genre.create(name:"액션")
Genre.create(name:"기능성게임")
Genre.create(name:"리듬액션")
Genre.create(name:"슈팅")
Genre.create(name:"전략시뮬레이션")
Genre.create(name:"소셜게임")
Genre.create(name:"퍼즐")
Genre.create(name:"아케이드")
Genre.create(name:"MMORPG")
Genre.create(name:"캐주얼게임")
Genre.create(name:"TGC")

doc = File.open("#{Rails.root}/seed/data1.tsv").readlines
counter = 0
doc.each do |line|
  counter+=1
  column = line.split("\t")
  seed = Hash.new
  seed[:genre] = column[0]
  seed[:platform] = column[1]
  seed[:name] = column[2]
  seed[:maker] = column[3]
  seed[:distribute] = column[4]
  seed[:date] = column[5]
  seed[:user_class] = column[6]
  seed[:content] = column[7]
  seed[:movie] = column[8]
  seed[:small_image] = column[9]
  seed[:big_image] = column[10]
  seed[:stat0] = column[12]
  seed[:stat1] = column[13]
  seed[:stat2] = column[14]
  seed[:stat3] = column[15]
  seed[:stat4] = column[16]

  if !seed[:stat3].nil? and seed[:stat3].include?("\n")
    seed[:stat3].slice!("\n")
  end
  if !seed[:stat4].nil? and seed[:stat4].include?("\n")
    seed[:stat4].slice!("\n")
  end

  if seed[:stat4].nil? or seed[:stat4] == "" 
    seed[:stat4] = (rand(3)+2).to_s
  end
  puts seed.inspect

  Game.data_from_seed seed
end
#
#
# game = Game.create(name: '스타크래프트', image: File.open("#{Rails.root}/seed_image/thumb/starcraft.jpg"), genre_ids: "1/2")
# PlatformGame.create(game_id:game.id, platform_id: 1)
# PlatformGame.create(game_id:game.id, platform_id: 2)
# GameInfo.create(game_id: game.id, image: File.open("#{Rails.root}/seed_image/big/starcraft.jpg"), maker: "블리자드", distribute:"손오공", date:"1996.6.5", user_class:"12", content: "스타 짱!")
# GameMovie.create(game_id: game.id, movie_url: "//www.youtube.com/embed/28MeoIRFtUw")
