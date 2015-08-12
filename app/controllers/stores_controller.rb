class StoresController < InheritedResources::Base
	before_action :authenticate_user!


  	private

	    def store_params
	      params.require(:store).permit(:name, :slug)
	    end
end

