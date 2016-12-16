class AddLatitudeAndLongitudeToLocation < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :latitude, :float
    add_column :locations, :longitude, :float
  end
end
