class BuyController < ApplicationController
  def songo
  @actor = Actor.find_by_name(params[:buyer])
    @song1 = Song.find_by_title(params[:song])
	if @song1 && @actor then 
	   @song2 = Song.create(:artist => @song1.artist, :title => @song1.title, 
			:time => @song1.time, :in_album => @song1.in_album, :actor_id => @actor.id)
	end
  end

end
