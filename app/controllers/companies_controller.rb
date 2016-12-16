class CompaniesController < ApplicationController
  helper_method :company_size
  include CompanySize

  def index
    @companies = Company.approved_companies.includes(:locations)
    @companies = @companies.company_size(params[:company_size]) if params[:company_size].present?
    @companies = @companies.industry_name(params[:industry_ids]) if params[:industry_ids].present?
    @industries = Industry.all
    @company_sizes = company_size_options
    raw_user_coordinates = request.location.coordinates
    @user_coordinates = UserLocation.coordinates(raw_user_coordinates)

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
      params[:industry_ids].each do |industry_id|
        industry = Industry.find(industry_id)
        @company.industries << industry
      end

      @location = @company.locations.create(location_params)
      @location.update(state: params[:state])
      @location.update(status: 'approved')
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
