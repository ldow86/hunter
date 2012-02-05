require 'spec_helper'

describe PhotosController do
	render_views

	describe "GET 'archives'" do 
		it "should be successful" do 
			get '/archives'
			response.should be_success
		end 
	end

	describe "GET 'delete'" do 

		before(:each) do 
			@photo = Factory(:photo)
		end 

		describe "as a non-signed-in user" do 
			it "should deny access" do 
				get :delete  
				response.should redirect_to(signin_path)
			end 
		end 

		describe "as a signed-in user" do 
	
			before(:each) do 
				@user = Factory(:user)
				test_sign_in(@user)
			end 

			it "should render the page" do 
				get :delete  
				response.should be_success
			end 
		end 
	end 

	describe "POST 'deletePhotos'" do 

		describe "as a non-signed in user" do 
			
			it "should protect the page" do
				post :deletePhotos
				response.should redirect_to(signin_path)
			end 
		end 

		describe "as a signed in user" do 

			before(:each) do 
				@user = Factory(:user)
				test_sign_in(@user)
				@photo = Factory(:photo)
			end 

			describe "failure" do 
				
				it "should not destroy a photo" do 
					lambda do 
						post :deletePhotos
					end.should_not change(Photo, :count)
					response.should redirect_to(delete_photos_path)
					flash[:error].should =~ /Error: No photos selected./
				end
			end 

			describe "success" do 

				it "should delete a photo" do 
					lambda do 
						post :deletePhotos, :ids => [@photo]
					end.should change(Photo, :count).by(-1)
					response.should redirect_to(delete_photos_path)
					flash[:success].should =~ /Photos deleted./
				end 
			end 
		end 
	end 		
end
