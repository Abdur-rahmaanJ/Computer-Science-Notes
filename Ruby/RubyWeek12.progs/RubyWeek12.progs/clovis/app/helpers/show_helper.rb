module ShowHelper

	def link_to_criteria(criterion)
		link_to(criterion.capitalize,
			:controller => "show",
			:action  =>  "list",
			:id  => criterion)
	end
end

