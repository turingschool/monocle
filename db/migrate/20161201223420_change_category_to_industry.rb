class ChangeCategoryToIndustry < ActiveRecord::Migration[5.0]
  def change
    rename_table :categories, :industries
  end
end
