class CompanyIndustry < ApplicationRecord
  belongs_to :industry
  belongs_to :company
end
