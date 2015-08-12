class User < ActiveRecord::Base
	# Adding friendly id and slug candidates
	extend FriendlyId
	friendly_id :slug_candidates, use: [:slugged,:finders]
	enum role: [:user, :vip, :admin]
	after_initialize :set_default_role, :if => :new_record?

	def set_default_role
		self.role ||= :user
	end

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :invitable, :database_authenticatable, :registerable, :confirmable,
	     :recoverable, :rememberable, :trackable, :validatable

	# Adding function to return role enum for admin pages
	def role_enum
		[:user,:vip,:admin]
	end

	# Try build a slug based on the following fields in increasing order of specifity
	def slug_candidates
		[
			[:name]
		]
	end
end
