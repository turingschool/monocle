class CreateStarredJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :starred_jobs do |t|
      t.string :title
      t.string :description
      t.string :location
      t.string :url
      t.string :posted_date
      t.string :remote
      t.string :company_name
      t.string :technologies

      t.timestamps 
    end
  end
end
