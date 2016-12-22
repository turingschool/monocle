class RemoveStateIdAndZipIdAndCityIdFromLocations < ActiveRecord::Migration[5.0]
  def change
    remove_column :locations, :state_id
    remove_column :locations, :city_id
    remove_column :locations, :zip_code_id
  end
end
