class AddAuthorToNotes < ActiveRecord::Migration[5.0]
  def change
    add_column :notes, :author, :string
  end
end
