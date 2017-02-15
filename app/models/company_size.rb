module CompanySize

  def company_size_options
    [
      '2-10',
      '11-50',
      '51-200',
      '201-500',
      '501-1000',
    ]
  end

  def company_size_filter_options
    [
      'All',
      '10',
      '50',
      '200',
      '500',
      '1000',
      '5000',
      '10000',
      '10001+'
    ]
  end
end
