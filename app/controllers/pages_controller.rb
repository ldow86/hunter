class PagesController < ApplicationController

	def home
		@title = "Home"
		@displayRecentPhotos = Photo.order("created_at DESC").limit(2)
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

	def submitContactForm
		RequestMailer.request_email(params[:petitioner],params[:replyEmailAddress],params[:imageNumber], params[:description]).deliver 
	end 

end
