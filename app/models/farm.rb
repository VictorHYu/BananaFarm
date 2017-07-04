class Farm < ApplicationRecord
	has_many:bananas
	has_one:fertilizer
	accepts_nested_attributes_for :bananas, :fertilizer
end
