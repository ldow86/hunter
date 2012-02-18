class RequestMailer < ActionMailer::Base
	default :from => "notifications@example.com"

	def request_email(petitioner, replyEmailAddress, imageNumber, description)
		@petitioner = petitioner 
		@replyEmailAddress = replyEmailAddress
		@imageNumber = imageNumber
		@description = description
		mail(:to => ["aprilsall@hotmail.com", "laura.alisson86@gmail.com"], :subject => "Photo use request from throughhunterseyes.com")
	end 
end

