class FertilizersController < ApplicationController
	def update
		sleep 3
		@fertilizer = Fertilizer.first;
		@fertilizer.increment(:value, by = 1)
		@fertilizer.save

		redirect_to bananas_path
	end
end