class AddressesController < ApplicationController
  before_action :set_address, only: %i[edit update destroy]

  def index
  end

  def new
    @address = Address.new
  end

  def edit
  end

  def create
    unset_others_default if address_params[:default]

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

  def update
    unset_others_default if address_params[:default]

    respond_to do |format|
      if @address.update address_params
        format.html do
          redirect_to addresses_url,
                      notice: "Address was successfully updated"
        end

        format.json { render :show, status: :updated, location: @address }
      else
        format.html do
          render :edit, status: :unprocessable_entity, location: @address
        end

        format.json do
          render json: @address.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      if @address.destroy
        format.html do
          redirect_to addresses_url,
                      notice: "Address was successfully deleted"
        end

        format.json { render :index, status: :deleted }
      else
        format.html do
          redirect_to addresses_url,
                      notice: "Failed to delete address"
        end

        format.json do
          render json: "Failed to delete address", status: :unprocessable_entity
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

  def set_address
    @address = Address.find params[:id]
  end

  def unset_others_default
    current_user.addresses.where(default: true).update(default: false)
  end
end
