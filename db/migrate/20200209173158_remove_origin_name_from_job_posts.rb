class RemoveOriginNameFromJobPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :job_posts, :origin_name
  end
end
