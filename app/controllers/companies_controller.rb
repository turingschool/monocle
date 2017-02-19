class CompaniesController < ApplicationController
  helper_method :company_size, :company_size_filter
  include CompanySize

  def index
    @industries = Industry.all
    @company_sizes = company_size
  end

  def show
    @finding = Finding.new
    @company = Company.find(params[:id])
    @pending_locations = Location.pending_locations
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
      flash[:danger] = "Missing required name field"
      redirect_to new_company_path
    end
  end

  private

  def company_params
    params.require(:company).permit(:name,
                                    :website,
                                    :products_services,
                                    :logo).merge(size: params[:size])
  end

  def company_size
    company_size_options
  end

  def company_size_filter
    company_size_filter_options
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
