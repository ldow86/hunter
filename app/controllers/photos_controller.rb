class PhotosController < ApplicationController

	before_filter :authenticate, :only => [:new, :create, :delete, :deletePhotos]

	caches_page :image

	def new
		@title = "Upload Photo" 
 	end

	def show
		@title = "View Image"
		@photo = Photo.find(params[:id])
	end 

	def create
		@photo = Photo.new(params[:photo])
		if @photo.save
			flash[:success] = "Your photo has been uploaded"
			redirect_to :controller => 'photos', :action => 'new'
		else
			@title = "Upload Photos" 			
			render 'new'
		end 
	end

	def image
		@photo = Photo.find(params[:id])
		send_data(@photo.binary_data, 
		          :type => @photo.content_type, 
		          :filename => @photo.filename, 
		          :disposition => 'inline')
	end 

	def index 
		@title = "Archives"
		@list = Photo.paginate(:page => params[:page])
	end 

	def delete
		@title = "Delete Photos"
		@list = Photo.paginate(:page => params[:page])
	end 

	def deletePhotos
		ids = params[:ids]
		if !ids.nil?
			params[:ids].each do |id|
				Photo.find(id).destroy
			end 
			flash[:success] = "Photos deleted."
		else 
			flash[:error] = "Error: No photos selected."
		end 
		redirect_to delete_photos_path
	end 

	private 
	
		def authenticate
			deny_access unless signed_in?
		end 
end
