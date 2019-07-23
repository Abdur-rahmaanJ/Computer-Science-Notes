class ShowController < ApplicationController

  def list_song
	@songs = Song.all
  end

  def album
	@name = params[:name]
	if !@name.blank?
	then @album_songs = Song.where(in_album: @name)
         @album_time = (@album_songs.collect {|song| song.time}).sum 
	else @album_songs = [] end
  end
  
  def actor
    @actors = Actor.all
  end

end
