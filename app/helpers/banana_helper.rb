module BananaHelper
    def get_max_banana_index (farmId)
        case when (Banana.where(farm_id: farmId).maximum("farm_banana_index") != nil)
            Banana.where(farm_id: farmId).maximum("farm_banana_index") + 1
        else
            1
        end
    end
    
    def get_banana_value (farmId)
        (1.2 ** get_max_banana_index(farmId)).round
    end
    
    def get_banana_name
        array = [ 'Spicy', 'Mild', 'Bland',
                  'Red', 'Yellow', 'Blue',
                  'Shiny', 'Rotten', 'Fuzzy']
        randNum = rand(array.length)
        array[randNum] + " Banana"
    end
end
