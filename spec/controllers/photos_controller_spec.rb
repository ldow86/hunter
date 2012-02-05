require 'spec_helper'

describe PhotosController do
	render_views

	describe "GET 'archives'" do 
		it "should be successful" do 
			get '/archives'
			response.should be_success
		end 
	end

	describe "authentication of new page" do 
		before(:each) do
			@user = Factory(:user)
		end  
			
		describe "for non-signed in users" do 

			it "should deny access to 'new'" do 
				get :photos/new, :id => @user 
				response.should redirect_to(signin_path)
			end 
		end 
	end 
end
