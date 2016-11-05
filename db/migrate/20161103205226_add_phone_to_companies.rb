class AddPhoneToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :phone, :citext
  end
end
