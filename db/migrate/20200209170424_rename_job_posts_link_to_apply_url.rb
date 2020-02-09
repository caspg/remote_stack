class RenameJobPostsLinkToApplyUrl < ActiveRecord::Migration[6.0]
  def change
    rename_column :job_posts, :link, :apply_url
  end
end
