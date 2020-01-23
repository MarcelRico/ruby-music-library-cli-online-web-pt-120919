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
      
  end
end


require_all 'lib'

