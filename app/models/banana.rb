class Banana < ApplicationRecord
	validates :length, presence: true
	validates :flavour, presence: true
	validates :value, presence: true
	belongs_to:farm

end
