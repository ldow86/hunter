require 'spec_helper'

describe "LayoutLinks" do
  
	it "should have a Home page at '/'" do 
		get '/'
		response.should have_selector('title', :content => "Home")
	end 

	it "should have a Contact page at '/contact'" do 
		get '/contact'
		response.should have_selector('title', :content => "Contact")
	end 

	it "should have an About Hunter page at '/abouthunter'" do 
		get '/abouthunter'
		response.should have_selector('title', :content => "About Hunter")
	end 

	it "should have an About Autism page at '/aboutautism'" do 
		get '/aboutautism'
		response.should have_selector('title', :content => "About Autism")
	end

	it "should have an Archives page at '/archives'" do 
		get '/archives'
		response.should have_selector('title', :content => "Archives")
	end 
end
