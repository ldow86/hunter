Factory.define :user do |user|
	user.name					"Example User"
	user.password				"foobar"
	user.password_confirmation 	"foobar"
end

Factory.define :photo do |photo|
	photo.filename		"Photo.jpg"
	photo.content_type	"image/jpeg"
	photo.binary_data	"photosbinarydata"
end 
	
