class RemoveIndustryIdFromCompany < ActiveRecord::Migration[5.0]
  def change
    remove_column :companies, :industry_id
  end
end
