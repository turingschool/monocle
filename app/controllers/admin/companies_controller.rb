class Admin::CompaniesController < ApplicationController
  before_action :verify_admin
  helper_method :company_size
  include CompanySize

  def index
    @pending_companies = Company.pending_companies
    @pending_locations = Location.pending_locations
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    company = Company.find(params[:id])
    if company.update(company_params)
      flash[:notice] = "Company information updated."
      redirect_to company_path(company)
    else
      flash.now[:danger] = company.errors.full_messages
      render :edit
    end
  end

  private
    def company_params
      params.require(:company).permit(:name,
                                      :website,
                                      :headquarters,
                                      :products_services,
                                      :status,
                                      :logo,
                                      :size)
    end

    def company_size
      company_size_options
    end

end
