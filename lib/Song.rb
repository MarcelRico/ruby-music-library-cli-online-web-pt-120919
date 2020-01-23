require 'pry'

class Song
  
  extend Concerns::Findable
  include Concerns::Findable

  @@all = []
  
  attr_accessor :name,:genre
  attr_reader :artist
  
  def initialize(name, artist=nil , genre=nil )
    @name = name
    self.send("artist=",artist) if artist != nil
    self.send("genre=",genre) if genre != nil
    self.save
  end
  
  def self.all
    @@all
  end
  
  def artist=(artist_obj)
    @artist = artist_obj #unless @artist != nil
    artist_obj.add_song(self) unless artist_obj.songs.include?(self)
  end
  
  def genre=(genre_obj)
    @genre = genre_obj unless @genre != nil
    genre_obj.songs << self unless genre_obj.songs.include?(self)
  end
  
  def self.new_from_filename(filename)
    
    # Split the filename and store the song name, artist, and genre in variables
    song_name = filename.split(" - ")[1]
    song_artist = filename.split(" - ")[0]
    song_genre = filename.split(" - ")[2].split(".")[0]
    
    song = self.create(song_name)
    song.artist = Artist.find_or_create_by_name(song_artist)
    song.genre = Genre.find_or_create_by_name(song_genre)
    
    song
  end
  
  def self.create_from_filename(filename)
    self.new_from_filename(filename)
  end

end