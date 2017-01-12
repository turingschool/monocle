class RemoveStateTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :states

  end
end
