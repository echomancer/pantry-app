class Stock < ActiveRecord::Base
  	belongs_to :store
  	belongs_to :food
  	belongs_to :user
  	# Adding friendly id and slug candidates
	extend FriendlyId
	friendly_id :slug_candidates, use: [:slugged,:finders]

	# Try build a slug based on the following fields in increasing order of specifity
	def slug_candidates
		[
			[self.store.name, self.food.full_name],
			[self.store.name, self.food.full_name, :bought]
		]
	end
	#resourcify

	validates :price, :quantity, :bought, presence: true
	validate :not_future

	private

		def not_future
			if !self.bought.nil?
				if self.bought > Time.now
					errors.add(:bought, "can't be in the future")
				end
			end
		end
end
