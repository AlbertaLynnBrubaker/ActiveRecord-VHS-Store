class Rental < ActiveRecord::Base
  belongs_to :client
  belongs_to :vhs

  def due_date
    
  end

end