class RemoveZipCodeTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :zip_codes
  end
end
