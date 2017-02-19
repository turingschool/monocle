class RemoveSlackuidAndSlackAccessTokenFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :slack_uid
    remove_column :users, :slack_access_token
  end
end
