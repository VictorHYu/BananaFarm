class Banana < ApplicationRecord
    validates :farm_banana_index, presence: true
    validates :farm_id, presence: true
    validates :banana_name, presence: true
    validates :count, presence: true
    validates :tier, presence: true
    validates :stat_type, presence: true
    validates :growth_stat, presence: true
    validates :time_stat, presence: true
    validates :value_stat, presence: true
    validates :weather_type, presence: true
    validates :is_special, :inclusion => {:in => [true, false]}
    
	belongs_to:farm
    
    after_initialize :if => :new_record? do |banana|
        @banana = banana
            
        setBananaDefaults
        rollBananaTier
        rollBananaName
        rollStatType
        rollStatDistribution
        rollWeatherType
    end

    # Class Methods
    def setBananaDefaults
        @banana.count = 0
        @banana.farm_banana_index = getBananaIndex
        @banana.farm_id = @banana.farm.id
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
        # Set base values
        @banana.growth_stat = 1
        @banana.time_stat = 1
        base_banana_value = 1.2
        
        # Modify scaling depending on type
        if (@banana.stat_type = 'Speed')
            @banana.time_stat = @banana.time_stat / 2
        elsif (@banana.stat_type = 'Growth')
            @banana.growth_stat = @banana.growth_stat + 0.1
        elsif (@banana.stat_type = 'Value')
            base_banana_value = base_banana_value + 0.1
        end
        
        @banana.value_stat = base_banana_value ** @banana.farm_banana_index
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
        case when (Banana.where(farm_id: @banana.farm.id).maximum("farm_banana_index") != nil)
            Banana.where(farm_id: @banana.farm.id).maximum("farm_banana_index") + 1
        else
            1
        end
    end
end
