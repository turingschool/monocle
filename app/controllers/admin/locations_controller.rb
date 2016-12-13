class Admin::LocationsController < ApplicationController
  before_action :verify_admin

  def edit
    @company  = Company.find(params[:company_id])
    @location = Location.find(params[:id])
  end

  def update
    location = Location.find(params[:id])
    company = location.company
    if location.update(location_params)
      flash[:notice] = "Company location information updated."
      redirect_to company_path(company)
    else
      flash.now[:danger] = location.errors.full_messages
      render :edit
    end
  end

  def destroy
    company = Company.find(params[:company_id])
    location = Location.find(params[:id])
    location.destroy
    redirect_to company_path(company)
  end

  private

  def location_params
    params.require(:location).permit(:status)
  end
end
