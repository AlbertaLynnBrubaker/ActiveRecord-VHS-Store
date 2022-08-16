class Genre < ActiveRecord::Base
  has_many :movie_genres
  has_many :movies, through: :movie_genres

  def self.most_popular
    MovieGenre.group(:movie_id).count.sort_by{|k, v| -v}.first(3).map{|k,v| Genre.find(k).name}
    # MovieGenre.group(:movie_id).count.sort_by{|k, v| -v}.first(3).map {|genre| Genre.find(genre[1]).name}
  end

end