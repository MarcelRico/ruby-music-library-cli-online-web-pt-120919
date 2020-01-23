class MusicLibraryController
  
  extend Concerns::Findable
  include Concerns::Findable

  attr_accessor :path

  def initialize(path ='./db/mp3s')
    @path = path
    MusicImporter.new(path).import
  end
  
  def call
      exit_flag = false
      while !exit_flag 
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        user_input = gets.chomp
        exit_flag = true if user_input == "exit"
        
        case user_input
        
        when "list songs"
          list_songs
        when "list artists"
          list_artists
        when "list genres"
          list_genres
        when "list artist"
          list_songs_by_artist
        when "list genre"
          list_songs_by_genre
        when "play song"
          play_song
        end
        
      end
  end
  
  def list_songs
    songs = Song.all
    songs.sort!{|a,b| a.name <=> b.name}
    songs.each_with_index{|song,idx| puts "#{idx+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end
  
  def list_artists
    list_obj(Artist)
  end
  
  def list_genres
    list_obj(Genre)
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_name = gets.chomp
    artist_obj = Artist.find_by_name(artist_name)
    if artist_obj != nil
      songs = artist_obj.songs.sort{|a,b| a.name <=> b.name}
      songs.each_with_index{|song,idx| puts "#{idx+1}. #{song.name} - #{song.genre.name}"}
    end
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_name = gets.chomp
    genre_obj = Genre.find_by_name(genre_name)
    if genre_obj != nil
      songs = genre_obj.songs.sort{|a,b| a.name <=> b.name}
      songs.each_with_index{|song,idx| puts "#{idx+1}. #{song.artist.name} - #{song.name}"}
    end
  end
  
  def play_song
    puts "Which song number would you like to play?"
    total_song_count = Song.all.count
    user_input = gets.chomp.to_i
    
    selected_song = Song.all.sort{|a,b| a.name <=> b.name}[user_input.to_i - 1]

    if selected_song != nil && user_input >= 1 && user_input < total_song_count
      puts "Playing #{selected_song.name} by #{selected_song.artist.name}"
    end
  end
  
end