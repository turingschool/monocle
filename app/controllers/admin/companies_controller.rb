class Admin::CompaniesController < ApplicationController
  before_action :verify_admin
  
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
                                      :street_address,
                                      :city_state_zip,
                                      :phone,
                                      :website,
                                      :headquarters,
                                      :products_services,
                                      :person_in_charge,
                                      :city_id,
                                      :state_id,
                                      :industry_id,
                                      :zip_code_id)
    end
end
