require 'spec_helper'

describe PagesController do

	describe "GET 'home'" do
		it "should be successful" do
			get 'home'
			response.should be_success
		end
	end

	describe "GET 'contact'" do
		it "should be successful" do
			get 'contact'
			response.should be_success
		end
	end

	describe "GET 'abouthunter'" do 
		it "should be successful" do 
			get 'abouthunter'
			response.should be_success
		end 
	end 

	describe "GET 'aboutautism'" do 
		it "should be successful" do 
			get 'aboutautism'
			response.should be_success
		end 
	end 

	describe "GET 'admin'" do 
		it "should be successful" do 
			get 'admin'
			response.should be_success
		end 
	end 

end
