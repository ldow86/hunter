require 'spec_helper'

describe UsersController do 
	render_views

	describe "GET 'show'" do 

		describe "as a non-signed in user" do 

			before(:each) do 
				@user = Factory(:user)
			end 
			
			it "should deny access" do 
				get :show, :id => @user 
				response.should redirect_to(signin_path)
				flash[:notice].should =~ /sign in/i
			end 
		end 	

		describe "as a signed-in user" do 

			before(:each) do 
				@user = Factory(:user)
				test_sign_in(@user)
			end 

			it "should be successful" do 
				get :show, :id => @user 
				response.should be_success
			end 

			it "should find the right user" do 
				get :show, :id => @user 
				assigns(:user).should == @user 
			end 

			it "should include the user's name" do 
				get :show, :id => @user 
				response.should have_selector("h1", :content => @user.name)
			end 
		end
	end

	describe "GET 'edit'" do 

		before(:each) do 
			@user = Factory(:user)
			test_sign_in(@user)
		end 

		it "should be successful" do 
			get :edit, :id => @user 
			response.should be_success
		end 

		it "should have the right title" do 
			get :edit, :id => @user 
			response.should have_selector("title", :content => "Edit user")
		end 
	end

	describe "PUT 'update'" do 

		before(:each) do 
			@user = Factory(:user)
			test_sign_in(@user)
		end 

		describe "failure" do 

			before(:each) do 
				@attr = { :name => "", :password => "", :password_confirmation => "" }
			end 

			it "should render the 'edit' page" do 
				put :update, :id=> @user, :user => @attr 
				response.should render_template('edit')
			end 

			it "should have the right title" do 
				put :update, :id=> @user, :user => @attr
				response.should have_selector("title", :content => "Edit user")
			end 
		end 

		describe "success" do 

			before(:each) do 
				@attr = { :name => "New Name", :password => "barbaz", :password_confirmation => "barbaz" }
			end 

			it "should change the user's attributes" do 
				put :update, :id => @user, :user => @attr 
				@user.reload
				@user.name.should == @attr[:name]
			end 

			it "should redirect to the user show page" do 
				put :update, :id=> @user, :user=> @attr 
				response.should redirect_to(user_path(@user))
			end 

			it "should have a flash message" do 
				put :update, :id => @user, :user => @attr 
				flash[:success].should =~ /updated/
			end 
		end 
	end 

	describe "authentication of edit/update pages" do 

		before(:each) do 
			@user = Factory(:user)
		end 
		
		describe "for non-signed-in users" do 

			it "should deny access to 'edit'" do 
				get :edit, :id => @user 
				response.should redirect_to(signin_path)
			end 

			it "should deny access to 'update'" do 
				put :update, :id => @user, :user => {}
				response.should redirect_to(signin_path)
			end 
		end 

		describe "for signed-in users" do 

			before(:each) do 
				wrong_user = Factory(:user, :name => "Bob Boblaw")
				test_sign_in(wrong_user)
			end 

			it "should require matching users for 'edit'" do 
				get :edit, :id => @user 
				response.should redirect_to(root_path)
			end 

			it "should require matching users for 'update'" do 
				put :update, :id => @user, :user => {}
				response.should redirect_to(root_path)
			end 
		end 
	end  
end
