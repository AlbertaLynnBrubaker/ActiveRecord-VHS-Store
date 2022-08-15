class Client < ActiveRecord::Base
  has_many :rentals
  has_many :vhs, through: :rentals

  def self.first_rental name, home_address, movie_name
    renter = Client.new name: name, home_address: home_address
    renter.save
    wanted_movie = Movie.find_by title: movie_name
    tape = Vhs.find_by movie_id: wanted_movie.id
    new_rental = Rental.new current: true, client_id: renter.id, vhs_id: tape.id
    new_rental.save
  end

end