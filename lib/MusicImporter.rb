class MusicImporter
  
  attr_accessor :path,:files
  
  def initialize(path)
    @path = path
    @files = get_mp3_files
  end
  
  def get_mp3_files
    files = Dir[@path + "/*.mp3"]
    songs = []
    files.map{|file| songs << (file.split("mp3s/")[1])}
    songs
  end
  
  def import
    list_of_filenames = get_mp3_files
    list_of_filenames.each{|filename| Song.create_from_filename(filename)}
  end


end