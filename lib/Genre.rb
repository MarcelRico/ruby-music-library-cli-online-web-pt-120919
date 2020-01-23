class Genre
  
  extend Concerns::Findable
  include Concerns::Findable
  
  @@all = []
  
  attr_accessor :name,:artist,:songs
  
  def initialize(name)
    @name = name
    @songs = []
    self.save
  end
  
  def self.all
    @@all  
  end
  
  def artists
    @songs.map{|song_obj| song_obj.artist}.uniq
  end

end