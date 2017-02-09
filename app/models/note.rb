class Note < ApplicationRecord
  belongs_to :user
  belongs_to :company

  def company_name
    company.name
  end

  def self.get_notes(company_id=nil, user=nil)
    if company_id
      Company.find(company_id).notes
    else
      user.notes
    end
  end

end
