class Api::V1::CompaniesController < ApplicationController
  def index
    @companies = Company.approved_companies.filter(params.slice(:company_size, :industry_ids)).includes(:locations)
  end
end
