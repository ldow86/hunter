describe RequestMailer do 

	before(:each) do 
		ActionMailer::Base.deliveries = []
	end 

	it "should send request email " do
		petitioner = "petitioner"
		replyEmailAddress = "replyEmailAddress"
		imageNumber = "imageNumber"
		description = "description"
 
		RequestMailer.request_email(petitioner, replyEmailAddress, imageNumber, description).deliver
		sent.first.subject.should =~ /Photo use request from throughhunterseyes.com/
		sent.first.body.should =~ /Name: #{ petitioner }/
		sent.first.body.should =~ /Email address: #{ replyEmailAddress }/
		sent.first.body.should =~ /Image number: #{ imageNumber }/
		sent.first.body.should =~ /Description of why #{ petitioner } would like to use the photo: #{ description }/
	end 

	def sent 
		ActionMailer::Base.deliveries
	end 
end 
