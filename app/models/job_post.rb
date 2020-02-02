class JobPost < ApplicationRecord
  has_many :job_post_skills
  has_many :skills, through: :job_post_skills

  # TODO(kacper): add pub_date, link, salary, company and benefits fields
end

# == Schema Information
#
# Table name: job_posts
#
#  id          :bigint           not null, primary key
#  description :text
#  origin_name :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  origin_id   :string
#
