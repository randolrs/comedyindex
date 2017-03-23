class ShowOccurrence < ActiveRecord::Base
  
  belongs_to :schedulable, polymorphic: true
  scope :remaining, lambda{where(["date >= ?",Time.now])}
  scope :previous, lambda{where(["date < ?",Time.now])}

  geocoded_by :address

  reverse_geocoded_by :latitude, :longitude


  def self.default_scope
    where(["id >= ?",1])
  end


  def self.nearby_show_occurrences(latitude, longitude, start_date, end_date)

  	location_show_occurrences = ShowOccurrence.near([latitude, longitude], 50)

  	location_and_date_show_occurences = location_show_occurrences.where(:date => start_date..end_date)
  	
  	return location_and_date_show_occurences 

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
