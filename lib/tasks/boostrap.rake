namespace :bootstrap do 
	desc "Add the default users" 
	task :all => :environment do 
		User.create( :name => 'Laura Dow', :password => 'password' )
		User.create( :name => 'April Sall', :password => 'password' )
		User.create( :name => 'Joe Sall', :password => 'password' )
	end 
end
