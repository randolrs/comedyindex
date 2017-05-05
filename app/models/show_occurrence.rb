class ShowOccurrence < ActiveRecord::Base
  
  belongs_to :schedulable, polymorphic: true
  scope :remaining, lambda{where(["date >= ?",Time.now])}
  scope :previous, lambda{where(["date < ?",Time.now])}

  geocoded_by :address

  reverse_geocoded_by :latitude, :longitude

  has_many :show_votes

  has_attached_file :image, 
  :styles => { :medium => "400x400#", :small => "70x70#", :thumb => "30x30#"},
  :s3_protocol => :https

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  

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

  def show

    show = Show.where(:id => self.schedulable_id).last

    if show

      return show

    else

      return nil

    end

  end

  def check_for_image

    unless self.image_file_name

      return self.show.image

    else

      return self.image

    end


  end

  def check_for_url_slug

    unless self.url_slug
      
      show = Show.find(self.schedulable_id)

      return show.url_slug

    else

      return self.url_slug

    end

  end

  def other_occurrences_soon

    occurrences_for_this_event = ShowOccurrence.where(:schedulable_id => self.schedulable_id)

    return occurrences_for_this_event.where(:date => self.date - 7.days..self.date + 7.days).where.not(:id => self.id)


  end

  def check_for_recommendation

    if !self.reason_we_recommend.blank?

      return self.reason_we_recommend

    elsif !self.show.reason_we_recommend.blank?

      return self.show.reason_we_recommend

    else

      return nil

    end

  end

  def check_for_about

    if !self.about.blank?

      return self.about

    elsif !self.show.about.blank?

      return self.show.about

    else

      return nil

    end

  end

  def check_for_video_preview

    if !self.video_url.blank?

      return self.video_url

    elsif !self.show.video_url.blank?

      return self.show.video_url

    else

      return nil

    end

  end

  def check_for_video_description

    if self.video_url

      if self.video_description
        return self.video_description
      else
        return nil
      end

    elsif self.show.video_url

      if self.show.video_description
        return self.show.video_description
      else
        return nil
      end

    else

      return nil

    end


  end


end
