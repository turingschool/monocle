class CompanyForm
  include CompanySize

  def company
    Company.new
  end

  def location
    Location.new
  end

  def industries
    Industry.all
  end

  def company_sizes
    company_size_options
  end
end
