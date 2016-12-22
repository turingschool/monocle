class RemoveCategoryIdFromCompanies < ActiveRecord::Migration[5.0]
  def change
    remove_column :companies, :category_id, :integer
  end
end
