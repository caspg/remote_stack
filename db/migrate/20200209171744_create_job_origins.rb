class CreateJobOrigins < ActiveRecord::Migration[6.0]
  def change
    create_table :job_origins do |t|
      t.string :name
    end

    add_reference :job_posts, :job_origin, foreign_key: true
  end
end
