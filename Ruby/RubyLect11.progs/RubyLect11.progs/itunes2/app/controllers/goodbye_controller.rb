class GoodbyeController < ApplicationController
  def wave
    actors = Actor.all
	@actor = actors.last
	@value = params[:id]
  end

end
