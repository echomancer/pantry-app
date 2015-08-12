class Food < ActiveRecord::Base
  	belongs_to :producer
  	enum unit: [:ounce,:fluid_ounce,:cup,:gram,:liter,:gallon,:pound]

  	# Adding friendly id and slug candidates
	extend FriendlyId
	friendly_id :slug_candidates, use: [:slugged,:finders]

	# Try build a slug based on the following fields in increasing order of specifity
	def slug_candidates
		[
			[self.producer.name,:name],
			[self.producer.name,:name,:upc]
		]
	end
	#resourcify
	validates :name, presence: true
	validate :duplicates

	def full_name
		"#{self.producer.name} #{self.name} #{self.total} #{self.unit.pluralize}"
	end

	def total
		self.servings * self.serving_size
	end

	private
		def duplicates
			self.name = self.name.titleize
			food = Food.find_by(name: self.name,producer_id: self.producer_id,servings: self.servings, serving_size: self.serving_size)
			if !food.nil?
				if food.id != self.id
					errors.add(:base, "This food has already been entered.")
				end
			end
		end
end
