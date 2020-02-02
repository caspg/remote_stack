# Join table between job_posts and skills
class JobPostSkill < ApplicationRecord
  belongs_to :skill
  belongs_to :job_post
end

# == Schema Information
#
# Table name: job_post_skills
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  job_post_id :bigint
#  skill_id    :bigint
#
# Indexes
#
#  index_job_post_skills_on_job_post_id  (job_post_id)
#  index_job_post_skills_on_skill_id     (skill_id)
#
