# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Genre.create(name:"액션")
Genre.create(name:"스포츠")
Genre.create(name:"전략")
Genre.create(name:"교육")

Platform.create(name:"PC")
Platform.create(name:"iOS")
Platform.create(name:"안드로이드")
Platform.create(name:"PS2")


game = Game.create(name: '스타크래프트', image: File.open("#{Rails.root}/seed_image/thumb/starcraft.jpg"), genre_ids: "1/2")
PlatformGame.create(game_id:game.id, platform_id: 1)
PlatformGame.create(game_id:game.id, platform_id: 2)
GameInfo.create(game_id: game.id, image: File.open("#{Rails.root}/seed_image/big/starcraft.jpg"), maker: "블리자드", distribute:"손오공", date:"1996.6.5", user_class:"12", content: "스타 짱!")
GameMovie.create(game_id: game.id, movie_url: "//www.youtube.com/embed/28MeoIRFtUw")
