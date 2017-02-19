class CreateFindings < ActiveRecord::Migration[5.0]
  def change
    create_table :findings do |t|
      t.integer :viability
      t.boolean :hiring

      t.timestamps
    end
  end
end
