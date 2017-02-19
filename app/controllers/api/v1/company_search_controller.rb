class Api::V1::CompanySearchController < ApplicationController

    skip_before_action :authorize!, only: [:show]

  def show
    company = Company.find_by(name: params[:name])
    if company
      render json: { company_id: company.id }
    else
      render json: "".to_json, status: 404
    end
  end

end
