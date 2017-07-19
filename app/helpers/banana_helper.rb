module BananaHelper
    def get_max_banana_index (farmId)
        case when (Banana.where(farm_id: farmId).maximum("farm_banana_index") != nil)
            Banana.where(farm_id: farmId).maximum("farm_banana_index") + 1
        else
            0
        end
    end
end
