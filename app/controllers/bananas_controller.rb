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
        @farm = Farm.find(params[:id])
        @banana = @farm.bananas.find(params[:banana_id])
        respond_with(@banana)
    end

	def update
		@farm = Farm.find(params[:farm_id])
        puts @farm.bananas.find(params[:id])
		@banana = @farm.bananas.find(params[:id])
        
        if @banana.save
            @banana = Banana.update(@banana.id, banana_params)
            redirect_to farm_path(@farm)
        else
            render 'edit'
        end
	end

	def add
		@farm = Farm.find(params[:farm_id])
		@banana = @farm.bananas.find(params[:banana_id])
		@banana.increment(:length, by = 1)
		@banana.save
        
        ActionCable.server.broadcast 'bananas',
            action: 'increment',
            id: params[:banana_id],
            farm: params[:farm_id]

        #redirect_to farm_path(@farm)
	end

	def remove
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
