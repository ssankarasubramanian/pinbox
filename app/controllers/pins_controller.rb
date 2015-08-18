class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @pins = Pin.all
    respond_with(@pins)
  end

  def show
    respond_with(@pin)
  end

  def new
    @pin = Pin.new
    respond_with(@pin)
  end

  def edit
  end

  def create
    @pin = Pin.new(pin_params)
    if @pin.save
			flash[:info] = 'Pin was successfully created.'
			redirect_to @pin
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
      @pin = Pin.find(params[:id])
    end

    def pin_params
      params.require(:pin).permit(:description)
    end
end
