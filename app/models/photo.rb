class Photo < ActiveRecord::Base

	validates :binary_data, :presence => true
	validates :content_type, :inclusion => { :in => ["image/jpeg"], :message => "You can only upload JPEGs" }

	def image_file=(input_data)
		self.filename = input_data.original_filename
		self.content_type = input_data.content_type.chomp
		self.binary_data = input_data.read 
	end 
end
