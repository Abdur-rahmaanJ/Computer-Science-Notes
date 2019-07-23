module TestHelper

	def link_to_criteria(criterion)
		link_to(criterion.upcase,
			:controller => "test",
			:action  =>  "tester",
			:id  => criterion)
	end

end
