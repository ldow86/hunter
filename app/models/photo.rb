require 'RMagick'

class Photo < ActiveRecord::Base

	self.per_page = 20

	validates :binary_data, :presence => true
	validates :content_type, :inclusion => { :in => ["image/jpeg"], :message => "You can only upload JPEGs" }

	def image_file=(input_data)
		self.filename = input_data.original_filename
		self.content_type = input_data.content_type.chomp

		image = Magick::Image.from_blob(input_data.read).first
		smallimage = image.resize_to_fit(600, 600)
		self.binary_data = smallimage.to_blob
	end 
end
