class CompanyIndex
  include CompanySize

  def initialize(params)
    @company_size = params[:company_size]
    @industry_ids = params[:industry_ids]
  end

  def companies
    to_show = Company.approved_companies.includes(:locations)
    to_show = to_show.company_size(@company_size) if @company_size
    to_show = to_show.industry_name(@industry_ids) if @industry_ids
    return to_show
  end

  def industries
    Industry.all
  end

  def company_sizes
    company_size_options
  end
end
