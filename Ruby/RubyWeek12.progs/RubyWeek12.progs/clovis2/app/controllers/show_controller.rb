class ShowController < ApplicationController
  def list
	@criterion = params[:id] || "id"
	sort_method = case @criterion
		when "name",
		     "artist",
			 "album" then lambda {|song|song.send(@criterion).downcase}
		when "id" then lambda {|song| song.id}
	end
	@out = Song.all.sort_by &sort_method
  end

end
