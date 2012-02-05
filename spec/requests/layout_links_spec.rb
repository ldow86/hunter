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

	it "should have an Admin page at '/admin'" do 
		get '/admin'
		response.should have_selector('title', :content => "Admin")
	end 

	describe "when signed in" do 
	
		before(:each) do 
			@user = Factory(:user)
			visit signin_path
			fill_in :name,		:with => @user.name
			fill_in :password,	:with => @user.password
			click_button
		end 

		it "should have a signout link" do 
			visit root_path
			response.should have_selector("a", href => signout_path, :content => "Sign out")
		end 

		it "should have a profile link" do 
			visit root_path
			response.should have_selector("a", :href => user_path(@user), :content => "Profile")
		end 
	end  
end
