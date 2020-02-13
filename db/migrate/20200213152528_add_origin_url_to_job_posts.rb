class AddOriginUrlToJobPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :job_posts, :origin_url, :string
  end
end
