class CompaniesController < ApplicationController
  def index
    @companies = Company.order(name: :asc)
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      flash[:notice] = "Company is pending approval."
      redirect_to company_path(@company)
    else
      flash.now[:danger] = @company.errors.full_messages
      render :new
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
                                    :category_id,
                                    :zip_code_id)
  end
end
