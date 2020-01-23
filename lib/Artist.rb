class Artist
  
  extend Concerns::Findable
  include Concerns::Findable
  
  @@all = []
  
  attr_accessor :name , :songs
  
  def initialize(name)
    @name = name
    @songs = []
    self.save
  end
  
  def self.all
    @@all  
  end
  
  def add_song(song_obj)
    (song_obj.artist = self) if !song_obj.artist
    (@songs << song_obj) unless @songs.include?(song_obj)
    song_obj
  end
  
  def genres
    @songs.map{|song_obj| song_obj.genre}.uniq
  end
  
    
end