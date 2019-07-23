class AddController < ApplicationController
  def song
	if params[:artist]
	then @song = Song.create(:artist => params[:artist], :title => params[:title], 
			:time => params[:length], :in_album => params[:album]) end
  end
end
