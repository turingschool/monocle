class StarredCompaniesController < ApplicationController
  def index
    @starred_companies = current_user.companies.order(name: :asc)
    render component: 'StarredCompanies', props: {companies: @starred_companies }
  end

  def create
    company = Company.find(params[:company_id])
    current_user.star(company)
  end

  def destroy
    current_user.companies.destroy(params[:id])
  end
end
