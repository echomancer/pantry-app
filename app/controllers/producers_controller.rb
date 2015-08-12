class ProducersController < InheritedResources::Base
	before_action :authenticate_user!


	private

		def producer_params
			params.require(:producer).permit(:name, :slug)
		end
end

