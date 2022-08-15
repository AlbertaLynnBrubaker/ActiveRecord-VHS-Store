class Genre < ActiveRecord::Base
  has_many :movie_genres
  has_many :movies, through: :movie_genres

  def self.most_popular
    MovieGenre.group(:movie_id).count.sort_by {|k, v| -v}.to_a.slice(0, 3).to_h.map{|k,v| Genre.find(k).name}
  end

end