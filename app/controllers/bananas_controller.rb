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
		@banana.increment(:count, by = 1)
		@banana.save
        
        #Add to banana count
        ActionCable.server.broadcast 'bananas',
            action: 'increment',
            id: params[:banana_id],
            farm: params[:farm_id]

        #redirect_to farm_path(@farm)
	end

	def remove
		@farm = Farm.find(params[:farm_id])
		@banana = @farm.bananas.find(params[:banana_id])
        
        coinsEarned = @banana.value_stat * @banana.count
        
        @farm.coins = @farm.coins + coinsEarned
        @farm.save
        
        @banana.count = 0
        @banana.save

        #Add to coins amount for farm
        ActionCable.server.broadcast 'bananas',
            action: 'sell',
            id: params[:banana_id],
            farm: params[:farm_id],
            coins: coinsEarned

        #redirect_to farm_path(@farm)
	end

	private
	def banana_params
        params.require(:banana).permit(:farm_banana_index,
                                       :farm_id,
                                       :banana_name,
                                       :count,
                                       :tier,
                                       :stat_type,
                                       :growth_stat,
                                       :time_stat,
                                       :value_stat,
                                       :weather_type,
                                       :is_special)
	end
end
