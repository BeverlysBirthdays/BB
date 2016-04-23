class User < ActiveRecord::Base

	# Use built-in rails support for password protection
	has_secure_password

	# Relationships

	# Validations
	validates_uniqueness_of :username
	validates_presence_of :password, on: :create 
	# validates_presence_of :password_confirmation, on: :create 
	# validates_confirmation_of :password, message: "does not match"
	validates_length_of :password, minimum: 4, message: "must be at least 4 characters long"
	validates_presence_of :role

	# Scopes

	# Methods

	# login by email address
	def self.authenticate(email, password)
		find_by_username(username).try(:authenticate, password)
	end

end
