class ShowOccurrence < ActiveRecord::Base
  
  belongs_to :schedulable, polymorphic: true
  scope :remaining, lambda{where(["date >= ?",Time.now])}
  scope :previous, lambda{where(["date < ?",Time.now])}

  def self.default_scope
    where(["id >= ?",1])
  end


  def self.nearby_show_occurrences(latitude, longitude, start_date, end_date)

  	location_shows = Show.near([latitude, longitude], 50)

  	date_shows = ShowOccurrence.where(:date => start_date..end_date)

  	location_date_shows = date_shows
  	

  	return location_shows

  end

  def latitude

  	if self.schedulable_id

  		if Show.where(:id => self.schedulable_id).exists?

  			return Show.find(self.schedulable_id).latitude
  		else

  		end
  	end

  end


  def longitude

  	if self.schedulable_id

  		if Show.where(:id => self.schedulable_id).exists?

  			return Show.find(self.schedulable_id).longitude
  		else

  		end

  	end

  end


end
