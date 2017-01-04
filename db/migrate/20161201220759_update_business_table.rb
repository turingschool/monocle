class UpdateBusinessTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :companies, :street_address, :citext
    remove_column :companies, :city_state_zip, :citext
    remove_column :companies, :city_id, :integer
    remove_column :companies, :state_id, :integer
    remove_column :companies, :zip_code_id, :integer
    remove_column :companies, :phone, :citext
    remove_column :companies, :person_in_charge, :citext
    remove_column :companies, :status, :integer
  end
end
