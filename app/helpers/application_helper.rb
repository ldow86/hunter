module ApplicationHelper

	def title
		base_title = "Through Hunter's Eyes"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end 
	end
end
