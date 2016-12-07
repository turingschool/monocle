class AddStateAndCityAndZipCodeToLocation < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :zip_code, :string
    add_column :locations, :city, :citext
    add_column :locations, :state, :string
  end
end
