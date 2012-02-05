class PagesController < ApplicationController
	def home
		@title = "Home"
	end

	def contact
		@title = "Contact"
	end	

	def abouthunter
		@title = "About Hunter"
	end 
	
	def aboutautism
		@title = "About Autism"
	end 

	def archives
		@title = "Archives"
	end 

	def admin
		@title = "Admin"
	end 

end
