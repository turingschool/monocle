class Moderator::CompaniesController < ApplicationController
  before_action :verify_moderator_or_admin

  def index
    @pending_companies = Company.pending_companies
    @pending_locations = Location.pending_locations
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    company = Company.find(params[:id])
    params[:approve] ? company.approved : company.rejected
    flash[:notice] = "#{company.name} Status Successfully #{company.status.capitalize}"
    redirect_to moderator_companies_approval_path
  end
end
