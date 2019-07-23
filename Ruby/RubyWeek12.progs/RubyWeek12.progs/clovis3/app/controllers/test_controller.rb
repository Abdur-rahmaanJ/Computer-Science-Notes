class TestController < ApplicationController
  def tester
  @criterion2 = params[:id] || "id"
	sort_method = case @criterion2
		when "name",
		     "artist",
			 "album" then lambda {|song|song.send(@criterion2).downcase}
		when "id" then lambda {|song| song.id}
	end
	@out2 = Song.all.sort_by &sort_method
  end
end
