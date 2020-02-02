class Skill < ApplicationRecord
  has_many :job_post_skills
  has_many :job_posts, through: :job_post_skills

  validates :name, presence: true
end

# == Schema Information
#
# Table name: skills
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_skills_on_name  (name) UNIQUE
#
