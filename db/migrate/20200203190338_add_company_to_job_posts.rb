class AddCompanyToJobPosts < ActiveRecord::Migration[6.0]
  def change
    add_reference :job_posts, :company, null: true, foreign_key: true
  end
end
