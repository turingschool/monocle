class AddUserToStarredJob < ActiveRecord::Migration[5.0]
  def change
    add_reference :starred_jobs, :user, foreign_key: true
  end
end
