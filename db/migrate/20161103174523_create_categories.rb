class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      enable_extension 'citext'

      t.citext :name

      t.timestamps
    end
  end
end
