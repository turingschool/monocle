class AddUidToStarredJob < ActiveRecord::Migration[5.0]
  def change
    add_column :starred_jobs, :uid, :citext
  end
end
