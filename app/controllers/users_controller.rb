class UsersController < ApplicationController
	before_filter :authenticate, :only => [:show, :edit, :update]
	before_filter :correct_user, :only => [:edit, :update]

	def show
		@user = User.find(params[:id])
		@title = @user.name 
	end 

	def edit
		@user = User.find(params[:id])
		@title = "Edit user" 
	end 

	def update 
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			flash[:success] = "Profile updated." 
			redirect_to @user 
		else 
			@title = "Edit user" 
			render 'edit'
		end 
	end 

	private 

		def authenticate
			deny_access unless signed_in?
		end 

		def correct_user 
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end 
end 
