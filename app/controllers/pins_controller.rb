class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]
	before_action :correct_user, only: [:edit, :update, :destroy]

  respond_to :html

  def index
    @pins = Pin.all
    respond_with(@pins)
  end

  def show
    respond_with(@pin)
  end

  def new
		@pin = current_user.pins.build
    respond_with(@pin)
  end

  def edit
  end

  def create
    @pin = current_user.pins.build(pin_params)
    if @pin.save
			flash[:info] ='Pin was successfully created.'
			respond_with(@pin)			
    else
      render action: 'new'
    end
  end

  def update
   if @pin.update(pin_params)
		 flash[:info] = 'Pin was successfully updated.'
		 redirect_to @pin
	 else
		 render action: 'edit'
	 end
  end

  def destroy
    @pin.destroy
    respond_with(@pin)
  end

  private
    def set_pin
			@pin = Pin.find_by(id: params[:id])
    end
		
		def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path, notice: "Not authorized to edit this pin" if @pin.nil?
    end

    def pin_params
			params.require(:pin).permit(:description,:image)
    end
end
