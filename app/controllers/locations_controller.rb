class LocationsController < ApplicationController
  helper_method :us_states
  include StateHelper

  def new
    @company = Company.find(params[:company_id])
    @location = Location.new
  end

  def create
    @company = Company.find(params[:company_id])
    @location = @company.add_location(location_params)
    @location.state = params[:state]
    if @location.save
      flash[:notice] = 'Location pending approval by moderator'
      redirect_to company_path(@company)
    else
      flash.now[:error] = @location.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
    @company = Company.find(params[:company_id])
    @location = Location.find(params[:id])
  end

  def update
    @company = Company.find(params[:company_id])
    @location = Location.find(params[:id])
    @location.assign_attributes(location_params)
    @location.state = params[:state]

    if @location.save
      redirect_to company_path(@company)
    else
      flash.now[:error] = @location.errors.full_messages.join(', ')
      render :edit

    end
  end

  def destroy
  end

  private
    def location_params
      params.require('location').permit(:street_address,
                                        :street_address_2,
                                        :phone,
                                        :primary_contact,
                                        :state,
                                        :city,
                                        :zip_code)
    end

    def us_states
      state_options
    end
end
