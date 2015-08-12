class StocksController < InheritedResources::Base
	load_and_authorize_resource
	before_action :set_stock, only: [:show, :edit, :update, :destroy, :update_remaining]

	def index
		@stocks = Stock.where(user_id: current_user.id).where("remaining > 0").order(:food_id,:bought).paginate(page: params[:page], :per_page => 10)
		@totals = Stock.select("food_id, SUM(price) as price, SUM(quantity) as quantity, SUM(discount) as discount").group(:food_id).order(:food_id)
	end

	def show
		if current_user == @stock.user
			respond_to do |format|
				format.html
				format.json {render json: @stock}
			end
		else
			redirect_to stocks_path, notice: 'Access Denied'
		end
	end

	# POST /stocks
	# POST /stocks.json
	def create
		@stock = Stock.new(stock_params)
		@stock.user = current_user
		if !@stock.quantity.nil?
			@stock.remaining = @stock.quantity * @stock.food.total # Get the total number of servings
		end

		respond_to do |format|
		  if @stock.save
		    format.html { redirect_to @stock, notice: 'Stock was successfully created.' }
		    format.json { render action: 'show', status: :created, location: @stock }
		  else
		    format.html { render action: 'new' }
		    format.json { render json: @stock.errors, status: :unprocessable_entity }
		  end
		end
	end

	# PATCH/PUT /stocks/1
	# PATCH/PUT /stocks/1.json
	def update
		if current_user == @stock.user
		    respond_to do |format|
		      if @stock.update(stock_params)
		      	@stock.update_column(:remaining, @stock.quantity * @stock.food.total)
		        format.html { redirect_to @stock, notice: 'Stock was successfully updated.' }
		        format.json { head :no_content }
		      else
		        format.html { render action: 'edit' }
		        format.json { render json: @stock.errors, status: :unprocessable_entity }
		      end
		    end
		else
			redirect_to stocks_path, notice: 'Access Denied'
		end
	end

	def update_remaining
		amount = params[:stock][:remaining].to_i
		if amount > 0
			@stock.remaining = @stock.remaining - amount
			@stock.save
			name = @stock.food.full_name
			if @stock.remaining > 0
				message = "Servings removed from #{name}"
			else
				message = "All serving from #{name} have been used."
			end
			redirect_to stocks_path, notice: message
		end
	end

	  # DELETE /stocks/1
	# DELETE /stocks/1.json
	def destroy
		if current_user == @stock.user 
			@stock.destroy
			respond_to do |format|
			  format.html { redirect_to stocks_url }
			  format.json { head :no_content }
			end
		else
			redirect_to stocks_path, notice: 'Access Denied'
		end
	end

  	private
	  	def set_stock
	  		@stock = Stock.find(params[:id])
	  	end

	    def stock_params
	      params.require(:stock).permit(:store_id, :food_id, :price, :quantity, :discount, :bought, :remaining)
	    end
end

