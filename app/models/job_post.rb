class JobPost < ApplicationRecord
  has_many :job_post_skills
  has_many :skills, through: :job_post_skills
end

# == Schema Information
#
# Table name: job_posts
#
#  id                   :bigint           not null, primary key
#  benefits             :text
#  description          :text
#  link                 :string
#  origin_name          :string
#  publication_datetime :datetime
#  title                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  origin_id            :string
#
