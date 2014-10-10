class Genre < ActiveRecord::Base
  def self.set_genre_from_seed seed
    seed.split(",")
    ret = Array.new
    Genre.all.each do |genre|
      if seed.include? genre.name
        ret.push(genre.id)
      end
    end

    ret.join("/")
  end
end
