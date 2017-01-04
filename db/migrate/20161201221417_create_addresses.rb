class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :street_address
      t.string :street_address_2
      t.string :phone
      t.string :primary_contact
      t.integer :status
      t.references :zip_code, foreign_key: true
      t.references :state, foreign_key: true
      t.references :city, foreign_key: true
      t.references :company, foreign_key: true
    end
  end
end
