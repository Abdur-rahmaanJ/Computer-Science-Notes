class MainController < ApplicationController
  layout 'start_to_end'

  def welcome
	@message = "Welcome"
  end

  def goodbye
    @message = "Goodbye"
	@entries = Entry.all
  end
end
