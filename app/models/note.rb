class Note < ApplicationRecord
  belongs_to :user
  belongs_to :company

  def company_name
    company.name
  end
end
