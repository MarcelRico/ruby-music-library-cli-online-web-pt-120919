require 'bundler'
Bundler.require

module Concerns
  module Findable
    
      def destroy_all
        all.clear
      end
      
      def create(obj,artist=nil,genre=nil)
        if self == Song
          new(obj,artist,genre)
        else
          new(obj)
        end
      end

      def save
        self.class.all << self
      end
      
      def find_by_name(name)
        all.detect{|obj| obj.name == name}
      end
      
    def find_or_create_by_name(song_name)
      song_obj = self.find_by_name(song_name)
      if song_obj == nil
        return create(song_name)
      else
        return song_obj
      end
    end
    
    def list_obj(klass)
      items = klass.all
      items.sort!{|a,b| a.name <=> b.name}
      items.each_with_index{|item,idx| puts "#{idx+1}. #{item.name}"}
    end
    
    def list_songs_by_item(klass)
      item_name = gets.chomp
      item_obj = klass.find_by_name(item_name)
      if item_obj != nil
        songs = item_obj.songs.sort{|a,b| a.name <=> b.name}
        return songs
        songs.each_with_index{|song,idx| puts "#{idx+1}. #{song.name} - #{song.genre.name}"}
      end
    end
      
  end
end


require_all 'lib'

