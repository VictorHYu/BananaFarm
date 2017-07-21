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
end
