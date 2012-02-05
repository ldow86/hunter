require 'spec_helper'

describe User do

	before(:each) do 
		@attr = { :name => "Example User", :password => "foobar", :password_confirmation => "foobar" }
	end 

	it "should create a new instance given valid attributes" do 
		User.create!(@attr)
	end 

	it "should require a name" do 
		no_name_user = User.new(@attr.merge(:name => ""))
		no_name_user.should_not be_valid
	end

	describe "password validations" do 
	
		it "should require a password" do 
			User.new(@attr.merge(:password => "")).should_not be_valid
		end

		it "should require a matching password confirmation" do 
			User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
		end  
	end

	describe "password encryption" do 
	
		before(:each) do 
			@user = User.create!(@attr)
		end 

		it "should have an encrypted password attribute" do 
			@user.should respond_to(:encrypted_password)
		end 

		it "should set the encrypted password" do 
			@user.encrypted_password.should_not be_blank
		end 

		describe "has_password? method" do 
		
			it "should be true if the passwords match" do 
				@user.has_password?(@attr[:password]).should be_true 
			end 

			it "should be false if the passwords don't match" do 
				@user.has_password?("invalid").should be_false
			end 
		end

		describe "authenticate method" do 

			it "should return nil on name/password mismatch" do 
				wrong_password_user = User.authenticate(@attr[:name], "wrongpass")
				wrong_password_user.should be_nil
			end 

			it "should return nil for a name with no user" do 
				nonexistent_user = User.authenticate("bar", @attr[:password])
				nonexistent_user.should be_nil
			end 

			it "should return the user on name/password mismatch" do 
				matching_user = User.authenticate(@attr[:name], @attr[:password])
				matching_user.should == @user 
			end 
		end  
	end 
end

