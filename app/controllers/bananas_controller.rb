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
        
        # Get banana stats
        rollBananaParams
                
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
    
    # Private Methods
    
    def rollBananaParams
        setBananaDefaults
        rollBananaTier
        rollBananaName
        rollStatType
        rollStatDistribution
        rollWeatherType
    end
    
    def setBananaDefaults
        @banana.count = 0
        @banana.farm_banana_index = getBananaIndex
        @banana.farm_id = @farm.id
    end
    
    def rollBananaTier
        # Roll tier between 0 and 2, then try to roll for special
        randNum = rand(3)
        specialRoll = rollSpecialBanana
        
        if specialRoll == 1
            @banana.tier = 3 # Golden
            @banana.is_special = true
        elsif specialRoll == 2
            @banana.tier = 4 # Weather
            @banana.is_special = true
        else
            @banana.tier = randNum
            @banana.is_special = false
        end
    end
    
    def rollBananaName
        # Randomize banana name
        case (@banana.tier)
            when 0
                array = ['Rotten', 'Fuzzy', 'Bland']
            when 1
                array = ['Yellow', 'Green', 'Normal']
            else
                array = ['Shiny', 'Spicy', 'Huge']
        end
        
        name = rand(array.length)
        @banana.banana_name = array[name] + " Banana";
    end
    
    def rollStatType
        # Bananas are 1 of 4 stat types: Speed, Growth, Value, Balanced
        randNum = rand(4)
        
        case (randNum)
            when 0
                @banana.stat_type = 'Speed'
            when 1
                @banana.stat_type = 'Growth'
            when 2
                @banana.stat_type = 'Value'
            else
                @banana.stat_type = 'Balanced'
        end
    end
    
    def rollStatDistribution
        # Bananas have 3 stats: Growth rate, Growth time, and Sell value
        @banana.growth_stat = 1
        @banana.time_stat = 2
        @banana.value_stat = 3
    end
    
    def rollWeatherType
        # Bananas are 1 of 3 Weather types: Warm, Normal, Cold
        randNum = rand(3)
        
        case (randNum)
            when 0
                @banana.weather_type = 'Hot'
            when 1
                @banana.weather_type = 'Cold'
            else
                @banana.weather_type = 'Normal'
        end
    end
    
    def rollSpecialBanana
        # Special bananas are rare appearances
        # Weather banana - special weather interactions
        # Golden banana - boosted stats
        randNum = rand(100)
        
        case (randNum)
            when 77
                1 # Golden
            when 88
                2 # Weather
            else
                0 # Nothing
        end
    end
    
    def getBananaIndex
        case when (Banana.where(farm_id: @farm.id).maximum("farm_banana_index") != nil)
            Banana.where(farm_id: @farm.id).maximum("farm_banana_index") + 1
        else
            1
        end
    end
    
    def getBananaValue
        @banana.value ** @banana.farm_banana_index
    end

end
