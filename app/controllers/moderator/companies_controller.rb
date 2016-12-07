class Moderator::CompaniesController < ApplicationController
  before_action :verify_moderator_or_admin

  def index
    @pending_companies = Company.pending_locations
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    location = Location.find(params[:id])
    params[:approve] ? location.approved : location.rejected
    flash[:notice] = "#{location.company.name} Location Status Successfully #{location.status.capitalize}"
    redirect_to moderator_companies_approval_path
  end
end
