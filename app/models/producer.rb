class Producer < ActiveRecord::Base
	# Adding friendly id and slug candidates
	extend FriendlyId
	friendly_id :slug_candidates, use: [:slugged,:finders]

	# Try build a slug based on the following fields in increasing order of specifity
	def slug_candidates
		[
			[:name]
		]
	end
	#resourcify
	validates :name, presence: true
	validate :duplicates

	private
		def duplicates
			self.name = self.name.titleize
			producer = Producer.find_by(name: self.name)
			if !producer.nil?
				if producer.id != self.id
					errors.add(:name, "already exists.")
				end
			end
		end
end
