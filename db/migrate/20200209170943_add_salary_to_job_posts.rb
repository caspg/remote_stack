class AddSalaryToJobPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :job_posts, :salary, :string
  end
end
