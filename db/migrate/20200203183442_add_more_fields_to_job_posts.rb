class AddMoreFieldsToJobPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :job_posts, :publication_datetime, :datetime
    add_column :job_posts, :link, :string
    add_column :job_posts, :benefits, :text
  end
end
