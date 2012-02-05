describe RequestMailer do 

	before(:each) do 
		ActionMailer::Base.deliveries = []
	end 

	it "should send request email " do 
		RequestMailer.request_email("petitioner", "replyEmailAddress", "imageNumber", "description")
		sent.first.subject.should = "Photo use request from throughhunterseyes.com"
		sent.first.body.should =~ /Name: #{"petitioner"}/
		sent.first.body.should =~ /Email address: #{"replyEmailAddress"}/
		sent.first.body.should =~ /Image Number: #{"imageNumber"}/
		sent.first.body.should =~ /Description: #{"description"}/
	end 

	def sent 
		ActionMailer::Base.deliveries
	end 
end 
