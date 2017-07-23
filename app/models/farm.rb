class Farm < ApplicationRecord
	has_many:bananas
	accepts_nested_attributes_for :bananas
end
