class CompaniesController < ApplicationController
  helper_method :company_size
  include CompanySize

  def index
    @industries = Industry.all
    @company_sizes = company_size_options
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
    @location = Location.new
    @industries = Industry.all
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      @company.attach_industries_and_location(params[:industry_ids], params[:state], location_params)
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
                                    :website,
                                    :headquarters,
                                    :products_services,
                                    :logo).merge(size: params[:size])
  end

  def company_size
    company_size_options
  end

  def location_params
    params.require(:location).permit(:street_address,
                                      :street_address_2,
                                      :phone,
                                      :primary_contact,
                                      :city,
                                      :zip_code).merge(state: params[:state])
  end

end
