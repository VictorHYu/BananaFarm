class FarmsController < ApplicationController
	respond_to :html, :xml, :json
    
    def index
		@allfarms = Farm.all
	end

	def show
		@farm = Farm.find(params[:id])
		@allbananas = @farm.bananas.all
	end

	def new
		@farm = Farm.new
	end

	def edit
		@farm = Farm.find(params[:id])
        respond_with(@farm)
	end
    
    def update
        @farm = Farm.find(params[:id])
        if @farm.save
            @farm = Farm.update(@farm.id,farm_params)
            redirect_to farms_path
        else
            render 'edit'
        end
    end

	def create
	  @farm = Farm.new(farm_params)
	 
	  if @farm.save
		redirect_to @farm
	  else
	  	render 'new'
	  end
	end

	def destroy
		  @farm = Farm.find(params[:id])
  		  @farm.destroy
 
  	      redirect_to farms_path
	end

	private
        def farm_params
            params.require(:farm).permit(:title)
        end
end
