class Moderator::LocationsController < ApplicationController
  before_action :verify_moderator_or_admin

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

  private

  def location_params
    params.require(:location).permit(:status)
  end
end
