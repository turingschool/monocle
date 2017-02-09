class ChangeStatusColumnNotes < ActiveRecord::Migration[5.0]
  def change
    remove_column :notes, :status
    add_column :notes, :status, :string, default: "private"
  end
end
