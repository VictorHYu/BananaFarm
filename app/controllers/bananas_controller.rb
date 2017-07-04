class BananasController < ApplicationController
	respond_to :html, :xml, :json

  	def new
		@farm = Farm.find(params[:farm_id])
    	@banana = @farm.bananas.new
   		respond_with (@banana)
	end

  	def create
	    @farm = Farm.find(params[:farm_id])
    	@banana = @farm.bananas.build(banana_params)
    	if @banana.save
    		redirect_to farm_path(@farm)
    	else
	  		render 'new'
    	end
  	end

	def edit
		@farm = Farm.find(params[:farm_id])
		@banana = @farm.bananas.find(params[:banana_id])
	end

	def update
		sleep 3
		@farm = Farm.find(params[:farm_id])
		@banana = @farm.bananas.find(params[:id])
		@banana.increment(:length, by = 1)
		@banana.save

		redirect_to farm_path(@farm)
	end

	def add
		sleep 3
		@farm = Farm.find(params[:farm_id])
		@banana = @farm.bananas.find(params[:banana_id])
		@banana.increment(:length, by = 1)
		@banana.save

		redirect_to farm_path(@farm)
	end

	def remove
		sleep 3

		@farm = Farm.find(params[:farm_id])
		@banana = @farm.bananas.find(params[:banana_id])
		@banana.decrement(:length, by = 1)
		@banana.save

		redirect_to farm_path(@farm)
	end

	private
	def banana_params
		params.require(:banana).permit(:length, :flavour, :value)
	end
end