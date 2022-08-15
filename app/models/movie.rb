class Movie < ActiveRecord::Base
  has_many :movie_genres
  has_many :vhs
  has_many :genres, through: :movie_genres

  def report_stolen
    available_tapes = Vhs.available_now
    matching_tapes = available_tapes.select do |tape|
      if (tape.movie_id == self.id)
        tape    
      end      
    end
    matching_tapes.sample.destroy
    print "THANK YOU FOR YOUR REPORT. THE FUZZ ARE ON IT."
  end

end