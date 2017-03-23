class ShowOccurrence < ActiveRecord::Base
  
  belongs_to :schedulable, polymorphic: true
  scope :remaining, lambda{where(["date >= ?",Time.now])}
  scope :previous, lambda{where(["date < ?",Time.now])}

  def self.default_scope
    where(["id >= ?",1])
  end


end
