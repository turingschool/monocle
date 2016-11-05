class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.references :category, foreign_key: true
      t.citext :name
      t.citext :street_address
      t.citext :city_state_zip
      t.citext :website
      t.citext :headquarters
      t.citext :products_services
      t.citext :person_in_charge

      t.timestamps
    end
  end
end
