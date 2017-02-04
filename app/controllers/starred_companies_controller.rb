class StarredCompaniesController < ApplicationController

  def create
    company = Company.find(params[:company_id])
    current_user.star(company)
  end

  def destroy
    current_user.companies.destroy(params[:id])
  end
end
