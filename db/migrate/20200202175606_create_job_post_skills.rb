class CreateJobPostSkills < ActiveRecord::Migration[6.0]
  def change
    create_table :job_post_skills do |t|
      t.belongs_to :skill
      t.belongs_to :job_post

      t.timestamps
    end
  end
end
