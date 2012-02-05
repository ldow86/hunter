require 'spec_helper'

describe PhotosController do
	render_views

	describe "GET 'new'" do

		describe "authentication of new page" do 

			describe "for non-signed in users" do 
				it "should deny access to 'new'" do 
					get :new, :id => @user 
					response.should redirect_to(signin_path)
				end 
			end

			describe "for signed in users" do 
				
				before(:each) do 
					@user = Factory(:user)
					test_sign_in(@user)
				end 

				it "should be successful" do 
					get :new 
					response.should be_success
				end 
			end 
		end  
	end 

	describe "create" do

		describe "failure" do 
 
			before(:each) do 
				@user = Factory(:user)
				test_sign_in(@user)
				@attr = { :filename => "", :binary_data => "", :content_type => "" }
			end 

			it "should not create a photo" do 
				lambda do 
					post :create, :photo => @attr 
				end.should_not change(Photo, :count)
			end 

			it "should have the right title" do 
				post :create, :photo => @attr 
				response.should have_selector("title", :content => "Upload Photos")
			end 

			it "should render the 'new' page" do 	
				post :create, :photo => @attr 
				response.should render_template('new')
			end 
		end 

		describe "success" do 
		
			before(:each) do 
				@user = Factory(:user)
				test_sign_in(@user)
				@attr = { :filename => "Test Photo.jpg", :binary_data => "hereisastring", :content_type => "image/jpeg" }
			end 

			it "should create a new photo" do 
				lambda do 
					post :create, :photo => @attr 
				end.should change(Photo, :count).by(1)
			end 

			it "should re-render the new page" do 
				post :create, :photo => @attr 
				response.should redirect_to(new_photo_path)
			end 
			
			it "should have a success message" do 
				post :create, :photo => @attr 
				flash[:success].should =~ /Your photo has been uploaded/
			end 
		end 
	end 

	describe "GET 'show'" do 

		before(:each) do 
			@photo = Factory(:photo)
		end 

		it "should be successful" do 
			get :show, :id => @photo
			response.should be_success
		end  

		it "should find the right photo" do 
			get :show, :id => @photo 
			assigns(:photo).should == @photo 
		end 
		
		it "should include the photo id number" do 
			get :show, :id => @photo 
			response.should have_selector("p", :content => @photo.id.to_s)
		end 
	end 

	describe "GET 'index'" do 

		before(:each) do 
			@photo = Factory(:photo)
			second = Factory(:photo, :filename => "SecondPhoto", :content_type => "image/jpeg", :binary_data => "photosbinarydata")
			third = Factory(:photo, :filename => "ThirdPhoto", :content_type => "image/jpeg", :binary_data => "photosbinarydata")
			@photos = [@photo, second, third]
			30.times do 
				@photos << Factory(:photo)
			end 
		end 

		it "should be successful" do 
			get :index
			response.should be_success
		end

		it "should have the right title" do 
			get :index 
			response.should have_selector("title", :content => "Archives")
		end 

		it "should have an element for each photo" do 
			get :index 
			@photos[0..2].each do |photo|
				response.should have_selector("a", :href => photo_path(photo))
			end 
		end 
		
		it "should paginate photos" do 
			get :index 
			response.should have_selector("div.pagination")
			response.should have_selector("span.disabled", :content => "Previous")
			response.should have_selector("a", :href => "/archives?page=2", :content => "2")
			response.should have_selector("a", :href => "/archives?page=2", :content => "Next")

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
