class AddPublicationDatetimeIndexToJobPosts < ActiveRecord::Migration[6.0]
  def change
    add_index :job_posts, :publication_datetime
  end
end
