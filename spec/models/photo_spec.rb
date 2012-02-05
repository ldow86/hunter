require 'spec_helper'

describe Photo do

	before(:each) do 
		@attr = { :filename => "Test Photo.jpg", :binary_data => "hereisastring", :content_type => "photo" }
	end 

	it "should create a new instance given valid attributes" do 
		Photo.create!(@attr)
	end 

	it "should require binary_data" do 
		no_binary_data = Photo.new(@attr.merge(:binary_data => ""))
		no_binary_data.should_not be_valid
	end

	it "should reject content_type that is not a jpg" do
		wrong_content_type = Photo.ew(@attr.merge(:content_type => "wrongcontenttype"))
		wrong_content_type.should_not be_valid
	end  
end
