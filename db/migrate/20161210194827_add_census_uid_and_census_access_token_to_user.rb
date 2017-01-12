class AddCensusUidAndCensusAccessTokenToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :census_uid, :string
    add_column :users, :census_access_token, :string
  end
end
