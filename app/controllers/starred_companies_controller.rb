class StarredCompaniesController < ApplicationController
  def index
    @starred_companies = current_user.companies.order(name: :asc)
  end

  def create
    company = Company.find(params[:company_id])
    current_user.star(company)
    redirect_to company_path(company), flash: { success: "Company added to starred list"}
  end

  def destroy
    current_user.companies.destroy(params[:id])
    redirect_back(fallback_location: starred_companies_path, flash: { success: "Company removed from starred list"} ) 
  end
end
