class AddStatusToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :status, :integer
    add_column :companies, :size, :citext
  end
end
