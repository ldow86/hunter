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

	describe "GET 'archives'" do 
		it "should be successful" do 
			get 'archives'
			response.should be_success
		end 
	end 

end
