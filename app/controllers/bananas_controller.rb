class BananasController < ApplicationController
	def index
		@allbananas = Banana.all
	end

	def show
		@singlebanana = Banana.find(params[:id])
	end

	def new
		@singlebanana = Banana.new
	end

	def edit
		@singlebanana = Banana.find(params[:id])
	end

	def create
	  @singlebanana = Banana.new(singlebanana_params) 	
	 
	  if @singlebanana.save
		redirect_to @singlebanana
	  else
	  	render 'new'
	  end
	end

	def update
		@singlebanana = Banana.find(params[:id])
 
  		if @singlebanana.update(singlebanana_params)
    		redirect_to @singlebanana
  		else
    		render 'edit'
  		end
	end

	def destroy
		  @singlebanana = Banana.find(params[:id])
  		  @singlebanana.destroy
 
  	      redirect_to bananas_path
	end

	private
  		def singlebanana_params
    		params.require(:bananas).permit(:length, :flavour)
  		end
end