class User < ActiveRecord::Base
	attr_accessor :password 
	attr_accessible :name, :password, :password_confirmation
	
	validates :name, :presence => true
	validates :password, :presence => true, :confirmation => true, :length => { :within => 6..40 }

	before_save :encrypt_password 
	
	def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password)
	end 

	def self.authenticate(name, submitted_password)
		user = find_by_name(name)
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
	end 

	def self.authenticate_with_salt(id, cookie_salt)
		user = find_by_id(id)
		(user && user.salt == cookie_salt) ? user : nil 
	end 

	private 
	
		def encrypt_password
			self.salt = make_salt unless has_password?(password)
			self.encrypted_password = encrypt(password)
		end 

		def encrypt(string)
			secure_hash("#{salt}--#{string}")
		end 	

		def make_salt
			secure_hash("#{Time.now.utc}--#{password}")
		end 

		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end 
end
