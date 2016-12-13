module StarredCompaniesHelper

  def link_to_toggle_user_starred_companies(user, company)

    if user.companies.include?(company)
      button_to('Unstar', starred_company_path(company_id: company.id), 
              method: :delete, 
              id: "unstar_link_#{company.id}",
              class: "unstar",
              remote: true)
    else
      button_to('Star', starred_companies_path(company_id: company.id, user_id: user.id), 
              method: :post, 
              id: "star_link_#{company.id}", 
              class: "star", 
              remote: true)
    end
  end

end