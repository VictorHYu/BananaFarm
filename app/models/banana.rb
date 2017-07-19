class Banana < ApplicationRecord
    validates :banana_name, presence: true
	validates :length, presence: true
	validates :farm_banana_index, presence: true
	validates :value, presence: true
	belongs_to:farm
end
