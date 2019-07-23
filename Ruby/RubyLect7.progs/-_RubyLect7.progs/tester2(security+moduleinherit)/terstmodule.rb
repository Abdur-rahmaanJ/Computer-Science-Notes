require_relative 'terstmodule'

module Tester
	def try_this
		puts "try this"
    self.tryanother
    tryathurd
	end

	def tryanother
		puts "try anohete"
	end

	def tryathurd
		puts "third   "
  end

  public :try_this
  protected :tryanother
  private  :tryathurd
end