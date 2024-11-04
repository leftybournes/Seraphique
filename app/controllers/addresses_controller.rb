class AddressesController < ApplicationController
  def new
    @address = Address.new
  end

  def create
    if address_params[:default]
      current_user.addresses.each do |address|
        address.default = false
        address.save
      end
    end

    @address = Address.new(address_params)
    current_user.addresses << @address

    respond_to do |format|
      if @address.save
        format.html do
          redirect_to addresses_url,
                      notice: "Address was successfully created"
        end
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json do
          render json: @address.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  private

  def address_params
    params.require(:address)
      .permit(
        :first_name,
        :last_name,
        :phone_number,
        :line_1,
        :line_2,
        :city,
        :state,
        :country,
        :postal_code,
        :default
      )
  end
end
